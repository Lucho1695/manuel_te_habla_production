class Response < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :answer, class_name: 'Answer', foreign_key: 'answer_id', optional: true
  belongs_to :question, class_name: 'Question', foreign_key: 'question_id'
  belongs_to :questionnaire, class_name: 'Questionnaire', foreign_key: 'questionnaire_id'

  def self.values_with_response_and_points(user)
    questionnaires = []
    questions = []
    self.where(user_id: user.ids).each do | response |
      if !response.questionnaire_id.nil? && !response.points.nil?
        questionnaires << response.questionnaire
        questions << response.question
      end
    end
    return questionnaires.uniq, questions.uniq
  end
end
