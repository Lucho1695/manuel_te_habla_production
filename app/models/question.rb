class Question < ApplicationRecord
  belongs_to :questionnaire

  has_many :answers, inverse_of: :question
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  enum question_type: {
    pregunta_con_respuesta_unica: 0, pregunta_con_respuesta_de_audio: 2
  }

  def self.question_type_select
    question_types.keys.map { |k| [k.titleize, k] }
  end
end
