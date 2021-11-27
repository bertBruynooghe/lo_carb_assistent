class ServiceWorkerController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    # The idea is to render the pack file inline using fragment cache

    def index
        # TODO: next solution is rather hacky, it resolves the erb of the pack AFTER building them, 
        # which poses a bit af a risk if somewhere in the files a `<%` appears.
        # But we currently need it to resolve the path of the application.js pack in the serviceworker for 
        # the offline cache...
        # OTOH, we might simply replace the application.js thingie like we replace the sourceMappingURL...
        respond_to do |format|
          format.js {
            render inline: getJs(), cache: true
          }
        end
    end

    def getJs
      service_worker_js_path = ActionController::Base.helpers.asset_pack_path('service_worker.js')
      file_path = Rails.root.join('public', service_worker_js_path[1..])
      content = File.read(file_path)
      pack_folder_url = service_worker_js_path.split('/')[...-1].join('/')
      content.gsub(/^\/\/# sourceMappingURL=/, '//# sourceMappingURL=' + pack_folder_url + '/')
    end
end
