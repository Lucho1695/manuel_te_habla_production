class Subcategory < ApplicationRecord
  has_one_attached :subcategories_image, dependent: :destroy
  belongs_to :category
  belongs_to :article, optional: true

  validates :title, presence: true

  def is_image?
    ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg', 'image/webp'].include?(self.subcategories_image.content_type)
  end
end
