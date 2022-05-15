class VideoFile < ApplicationRecord
  belongs_to :blob, dependent: :destroy
  belongs_to :video

  validates :filename, presence: false, length: {minimum: 1, maximum: 255}
  validates :content_type, presence: false, length: {minimum: 1, maximum: 255}

  # don't forget to take .to_blob from the following
  def get_thumb_nail( sizea = 125, sizeb = 125 )
    Magick::Image.from_blob( blob.data { self.format = "png" } ).first.scale(sizea,sizeb)
  end

  def is_video?
    ['video/jpeg', 'video/pjpeg', 'video/gif', 'video/png', 'video/x-png', 'video/jpg', 'video/webp'].include?(self.content_type)
  end

  def initialize(params = {})
    attachment = params.delete(:video_file) unless params.nil?
    super
    if attachment
      self.blob = Blob.new if self.blob.nil?
      self.blob.data = attachment.read
      self.filename = sanitize_filename(attachment.original_filename)
      self.content_type = attachment.content_type
      self.file_size = File.size(attachment.tempfile)
    end
  end

  def update(params = {})
    attachment = params.delete(:video_file)
    super
    if attachment
      self.blob = Blob.new if self.blob.nil?
      self.blob.data = attachment.read
      self.blob.save
      self.filename = sanitize_filename(attachment.original_filename)
      self.content_type = attachment.content_type
      self.file_size = File.size(attachment.tempfile)
      self.save
    end
  end

  private
  def sanitize_filename(filename)
    # Get only the filename, not the whole path (for IE)
    # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
    return File.basename(filename)
  end

end
