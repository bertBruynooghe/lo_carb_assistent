class CacheLoaderController < ApplicationController
  def index
    @url = params[:url]
    render layout: nil
  end
end
