class ServiceWorkerController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    # The idea is to render the pack file inline using fragment cache

    def index
        # next solution is rather hacky, it resolves the erb of the pack AFTER building them, 
        # which poses a bit af a risk if somewhere in the files a `<%` appears
        respond_to do |format|
          format.js {
            render inline: File.read(Rails.root.join("public", ActionController::Base.helpers.asset_pack_path("service_worker.js")[1..])), cache: true
          }
        end
    end
end
