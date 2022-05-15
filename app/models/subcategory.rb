class Subcategory < ApplicationRecord
  mount_uploader :subcategories_image, FilesUploader
  belongs_to :category
  belongs_to :article, optional: true

  validates :title, presence: true

  after_create :validate_params
  before_update :update_params

  def validate_params
    self.subcategories_image = "#{self.id}"
    self.save
  end

  def update_params
    self.subcategories_image = "#{self.id}"
  end

  def is_image?
    ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg', 'image/webp'].include?(self.subcategories_image.content_type)
  end
end
