class Answer < ApplicationRecord
  belongs_to :question
  mount_uploader :answer_file, FilesUploader

  after_create :validate_image

  def validate_image
    self.answer_file = "#{self.id}"
    self.save!
  end

end
