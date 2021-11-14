  class PwaManager
    def initialize(app)
        @app = app
    end
    
    def call(env)
      # don't do this in the init, asset helpers crash the pipeline if so
      @service_worker_path ||= ActionController::Base.helpers.asset_pack_path('serviceworker.js')
      @packs_root_folder ||=  @service_worker_path.split('/serviceworker').first

      orig_path = env['PATH_INFO']
      env['PATH_INFO'] =
        if (orig_path == '/serviceworker.js') then @service_worker_path
        # source maps are correctly fingerprinted, but wrongly situated 
        elsif (orig_path.start_with?('/serviceworker') && orig_path.end_with?('.js.map')) 
          (@packs_root_folder + orig_path)
        else orig_path
        end

      # let the other middleware handlers do their stuff
      status, headers, response = @app.call(env)
      headers['Cache-Control'] = 'no-cache' if @service_worker_path == ENV['PATH_INFO']
      [status, headers, response]
    end
  end
