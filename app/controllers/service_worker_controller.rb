class ServiceWorkerController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def index
        respond_to do |format|
          format.js {
            render inline: getJs(), cache: true #use fragment cache
          }
        end
    end

    def getJs
      service_worker_js_path = ActionController::Base.helpers.asset_pack_path('service_worker.js')
      file_path = Rails.root.join('public', service_worker_js_path[1..])
      content = begin
        File.read(file_path)
      rescue Errno::ENOENT
        Net::HTTP.start(request.host, Webpacker.dev_server.port) do |http|
          request = Net::HTTP::Get.new service_worker_js_path
        
          response = http.request request # Net::HTTPResponse object
          response.body
        end
      end  
      pack_folder_url = service_worker_js_path.split('/')[...-1].join('/')
      content
        .gsub(/^\/\/# sourceMappingURL=/, '//# sourceMappingURL=' + pack_folder_url + '/')
        # We need to resolve the path of the application.js pack here as it can't be resolved during
        # webpacker compilation
        .gsub(/asset_pack_path "application\.js"/, ActionController::Base.helpers.asset_pack_path('application.js'))
        .gsub!(/( version = )0/) { |m| m.gsub!($&, "#{$1}'#{ENV['SOURCE_VERSION'] || srand.to_s(16)}'" ) }
    end
end
