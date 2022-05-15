class SayIdea < ApplicationRecord
  belongs_to :say_idea, class_name: "SayIdea", foreign_key: 'say_ideas_id', optional: true
  mount_uploader :say_idea_image, FilesUploader

  enum types: {
    "Sujeto": 1,
    "Verbo": 2,
    "Complemento": 3
  }

  after_create :validate_params
  before_update :update_params

  def validate_params
    self.say_idea_image = "#{self.id}"
    self.save
  end

  def update_params
    self.say_idea_image = "#{self.id}"
  end

  def is_image?
    ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg', 'image/webp'].include?(self.say_idea_image.content_type)
  end
end
