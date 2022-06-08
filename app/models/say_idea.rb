class SayIdea < ApplicationRecord
  belongs_to :say_idea, class_name: "SayIdea", foreign_key: 'say_ideas_id', optional: true
  has_one_attached :say_idea_image, dependent: :destroy
  has_many :user, class_name: "User"

  enum types: {
    "Sujeto": 1,
    "Verbo": 2,
    "Complemento": 3
  }

  def is_image?
    ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg', 'image/webp'].include?(self.say_idea_image.content_type)
  end
end
