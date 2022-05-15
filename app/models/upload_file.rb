class UploadFile < ApplicationRecord

  belongs_to :blob, dependent: :destroy
  belongs_to :category, class_name: "Category", foreign_key: "category_id", optional: true
  belongs_to :person, class_name: "Person", foreign_key: "person_id", optional: true
  belongs_to :video, class_name: "Video", foreign_key: "video_id", optional: true
  belongs_to :user, class_name: "User", foreign_key: "user_id", optional: true

  validates :filename, presence: false, length: {minimum: 1, maximum: 255}
  validates :content_type, presence: false, length: {minimum: 1, maximum: 255}

  before_save :validate_user

  def validate_user
    if self.user_id == 0
      self.id = 0
    end
  end

  # don't forget to take .to_blob from the following
  def get_thumb_nail( sizea = 125, sizeb = 125 )
    Magick::Image.from_blob( blob.data { self.format = "png" } ).first.scale(sizea,sizeb)
  end

  def is_image?
    ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg', 'image/webp'].include?(self.content_type)
  end

  def have_principal?
    if !self.principal_file
      return true
    end
  end

  def initialize(params = {})
    attachment = params.delete(:upload_file) unless params.nil?
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
    attachment = params.delete(:upload_file)
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
