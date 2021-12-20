class WebmanifestController < ApplicationController
  # TODO: this should probably not be loaded when the user isn't authenticated, 
  # so should probably be blocked in the application layout.
  
  skip_before_action :authenticate_user!

  def index
    respond_to do |format|
      format.webmanifest { render json:  getJSON() }
    end
  end

  private 
  def getJSON
    # TODO: deduplicate the same code in service_worker_controller
    app_webmanifest_path = ActionController::Base.helpers.asset_pack_path('app.webmanifest.erb')
    file_path = Rails.root.join('public', app_webmanifest_path[1..])
    begin
      File.read(file_path)
    rescue Errno::ENOENT
      Net::HTTP.start(request.host, Webpacker.dev_server.port) do |http|
        request = Net::HTTP::Get.new app_webmanifest_path
      
        response = http.request request # Net::HTTPResponse object
        response.body
      end
    end  
  end
end
