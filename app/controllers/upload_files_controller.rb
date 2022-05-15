class UploadFilesController < ApplicationController

  before_action :set_upload_file, only: [:show, :show_upload_file_thumbnail, :show_upload_file, :show_small_upload_file_thumbnail]
  before_action :authenticate_user!

  def show_upload_file_thumbnail
    if @upload_file.principal_file && @upload_file.is_image?
      send_data @upload_file.get_thumb_nail.to_blob,
        filename: @upload_file.filename,
        type: "image/png",
        disposition: 'inline'
    else
      if @upload_file.is_image?
        send_data @upload_file.get_thumb_nail.to_blob,
          filename: @upload_file.filename,
          type: "image/png",
          disposition: 'inline'
      else
        image = Magick::Image.new(250, 250){ self.background_color= "#AAA"}
        image.format = "PNG"
        send_data image.to_blob,
            filename: "#{@upload_file.id.to_s}_thumb.png",
            type: "image/png",
            disposition: 'inline'
      end
    end
  end

  def show_upload_file
    send_data @upload_file.blob.data,
        filename: @upload_file.filename,
        type: @upload_file.content_type,
        disposition: 'inline'
  end

  def show_small_upload_file_thumbnail
    if @upload_file.is_image?
      send_data @upload_file.get_thumb_nail(250, 250).to_blob,
        filename: @upload_file.filename,
        type: "image/png",
        disposition: 'inline'
    else
      image = Magick::Image.new(250, 250){ self.background_color= "#AAA"}
      image.format = "PNG"
      send_data image.to_blob,
          filename: "#{@upload_file.id.to_s}_thumb.png",
          type: "image/png",
          disposition: 'inline'
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_upload_file
    @upload_file = UploadFile.find params[:id]
  end

end
