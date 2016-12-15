class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new
    @upload.attributes = upload_params

    respond_to do |format|
      if @upload.save
        format.html { redirect_to new_upload_path, notice: 'Upload was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def upload_params
    params.require(:upload).permit(:content)
  end
end
