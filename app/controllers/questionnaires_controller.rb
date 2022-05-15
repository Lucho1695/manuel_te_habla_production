class QuestionnairesController < ApplicationController
  before_action :set_questionnaire, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    record_activity("Ingreso a cuestionarios")
    @response_questionnaires = Response.where(user_id: current_user).pluck(:questionnaire_id)
    if current_user.user_roles == "SuperAdmin"
      @questionnaires = Questionnaire.all
    elsif current_user.user_roles == "Adulto Responsable"
      @questionnaires = Questionnaire.where(creator_id: current_user.id)
    elsif current_user.user_roles == "Niño"
      person = Person.find_by(email: current_user.email)
      @questionnaires = Questionnaire.where(creator_id: person.user_id)
    end
  end

  def show

  end

  def new
    @questionnaire = Questionnaire.new
  end

  def edit
  end

  def create
    @questionnaire = Questionnaire.new(questionnaire_params)
    @questionnaire.creator_id = current_user.id
    if @questionnaire.save
      redirect_to @questionnaire, notice: 'Questionnaire was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @questionnaire.update(questionnaire_params)
      redirect_to @questionnaire, notice: 'Questionnaire was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @questionnaire.questions.each do | question |
      question.answers.each do | answer |
        answer.delete
      end
      question.delete
    end
    @questionnaire.destroy
    redirect_to questionnaires_url, notice: 'Questionnaire was successfully destroyed.'
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  def questionnaire_params
    params.require(:questionnaire).permit(
      :name,
      :creator_id,
      questions_attributes: [
        :_destroy,
        :id,
        :question_type,
        :name,
        answers_attributes: [
          :_destroy, :id, :name, :answer_file
        ]
      ]
    )
  end
end
