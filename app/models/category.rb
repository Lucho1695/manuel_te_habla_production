class Category < ApplicationRecord
  mount_uploader :category_image, FilesUploader
  has_many :user, class_name: "User"

  has_many :subcategories, inverse_of: :category
  accepts_nested_attributes_for :subcategories, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
