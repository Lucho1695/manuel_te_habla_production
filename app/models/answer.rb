class Answer < ApplicationRecord
  belongs_to :question
  has_one_attached :answer_file, dependent: :destroy


end
