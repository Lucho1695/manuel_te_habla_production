class VideoFilesController < ApplicationController

  before_action :set_video_files, only: [:show, :show_video_files, :show_small_category_video]

  def show_video_files
    if @video_files.is_video?
      send_data @video_files.get_thumb_nail(400, 400).to_blob,
        filename: @video_files.filename,
        type: "image/png",
        disposition: 'inline'
    else
      image = Magick::Image.new(70, 70){ self.background_color= "#AAA"}
      image.format = "PNG"
      send_data image.to_blob,
        filename: "#{@video_files.id.to_s}_thumb.png",
        type: "image/png",
        disposition: 'inline'
    end
  end

  def show_small_category_video
    if @video_files.is_video?
      @video_files
    else
      @video_files
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_video_files
    @video_files = VideoFile.find params[:id]
  end

end
