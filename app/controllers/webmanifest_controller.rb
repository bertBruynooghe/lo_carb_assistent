class WebmanifestController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    respond_to do |format|
      format.webmanifest { render json:  {
        name: "Eat by numbers",
        short_name: "Meals",
        start_url: "/",
        theme_color: "#000000",
        background_color: "#FFFFFF",
        display: "fullscreen",
        orientation: "portrait"
      }
    }
    end
  end
end
