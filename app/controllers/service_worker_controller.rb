class ServiceWorkerController < ApplicationController
    # not sure if we need this: we should be logged in before fetching the service worker
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
      content.gsub(/(\/\/# sourceMappingURL=).*$/) do |m| 
        m.gsub!($&, "#{$1}#{helpers.asset_pack_path('service_worker.js.map')}")
      end
    end
end
