class ThemesController < ApplicationController

  before_action :set_theme, only: [:show, :show_category_themes, :show_small_category_image]

  def show_category_themes
    if @theme.is_image?
      send_data @theme.get_thumb_nail(400, 400).to_blob,
        filename: @theme.filename,
        type: "image/png",
        disposition: 'inline'
    else
      image = Magick::Image.new(70, 70){ self.background_color= "#AAA"}
      image.format = "PNG"
      send_data image.to_blob,
        filename: "#{@theme.id.to_s}_thumb.png",
        type: "image/png",
        disposition: 'inline'
    end
  end

  def show_small_category_image
    if @theme.is_image?
      send_data @theme.get_thumb_nail(120, 120).to_blob,
        filename: @theme.filename,
        type: "image/png",
        disposition: 'inline'
    else
      image = Magick::Image.new(70, 70){ self.background_color= "#AAA"}
      image.format = "PNG"
      send_data image.to_blob,
        filename: "#{@theme.id.to_s}_thumb.png",
        type: "image/png",
        disposition: 'inline'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_theme
    @theme = ThemeFile.find params[:id]
  end

end
