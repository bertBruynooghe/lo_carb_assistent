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
        orientation: "portrait",
        icons: [
          { 
            src: ActionController::Base.helpers.image_path('maskable_icon_x48.png'),
            sizes: '48x48',
            type: 'image/png'
          },
          { 
            src: ActionController::Base.helpers.image_path('maskable_icon_x72.png'),
            sizes: '72x72',
            type: 'image/png'
          },
          { 
            src: ActionController::Base.helpers.image_path('maskable_icon_x96.png'),
            sizes: '96x96',
            type: 'image/png'
          },
          { 
            src: ActionController::Base.helpers.image_path('maskable_icon_x128.png'),
            sizes: '128x128',
            type: 'image/png'
          },
          { 
            src: ActionController::Base.helpers.image_path('maskable_icon_x192.png'),
            sizes: '192x192',
            type: 'image/png'
          },
          { 
            src: ActionController::Base.helpers.image_path('maskable_icon_x384.png'),
            sizes: '384x384',
            type: 'image/png'
          },
          { 
            src: ActionController::Base.helpers.image_path('maskable_icon_x512.png'),
            sizes: '512x512',
            type: 'image/png'
          },
          { 
            src: ActionController::Base.helpers.image_path('maskable_icon.png'),
            sizes: '610x610',
            type: 'image/png'
          }
        ]
      }
    }
    end
  end
end
