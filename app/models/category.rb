class Category < ApplicationRecord
  has_one_attached :category_image, dependent: :destroy
  has_many :user, class_name: "User"

  has_many :subcategories, inverse_of: :category
  accepts_nested_attributes_for :subcategories, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
