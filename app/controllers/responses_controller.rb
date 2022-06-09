class ResponsesController < ApplicationController
  before_action :set_response, only: %i[ edit update destroy ]
  before_action :authenticate_user!

  # GET /responses or /responses.json
  def index
    if current_user.user_roles != "Niño"
      responses = Response.where.not(questionnaire_id: nil)
      @responses = Questionnaire.find(responses.pluck(:questionnaire_id).uniq)
    else
      redirect_to questionnaires_path
    end
  end

  # GET /responses/1 or /responses/1.json
  def show
    if current_user.user_roles == "Niño"
      @questions = Question.where(questionnaire_id: params[:questionnaire_id])
      @responses = Response.where(questionnaire_id: params[:questionnaire_id], user_id: current_user.id)
    else
      @questions = Question.where(questionnaire_id: params[:questionnaire_id])
      if !params[:filter].nil?
        @users = params[:get][:person_id]
        @question = params[:get][:question_id]
        case !params[:filter].nil?
        when !params[:get][:person_id].join.empty? && params[:get][:question_id].join.empty?
          @responses = Response.where(user_id: params[:get][:person_id], questionnaire_id: params[:questionnaire_id])
        when !params[:get][:question_id].join.empty? && params[:get][:person_id].join.empty?
          @responses = Response.where(questionnaire_id: params[:questionnaire_id], question_id: params[:get][:question_id])
        when !params[:get][:person_id].join.empty? && !params[:get][:question_id].join.empty?
          @responses = Response.where(question_id: params[:get][:question_id], user_id: params[:get][:person_id], questionnaire_id: params[:questionnaire_id])
        else
          @responses = Response.where(questionnaire_id: params[:questionnaire_id])
        end
      else
        @responses = Response.where(questionnaire_id: params[:questionnaire_id])
      end
    end
  end

  # GET /responses/new
  def new
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @response = Response.new
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses or /responses.json
  def create
    if params[:response][:response_type] == "2"
      params[:response][:question_id].each do | question_id |
        @response = Response.new(response_params)
        @response.user_id = current_user.id
        @response.audio_response = params[:response]["audio_response_#{question_id.first}"]
        @response.question_id = question_id.first
        @response.response_type = params[:response][:response_type]
        @response.questionnaire_id = params[:response][:questionnaire_id]
        @response.save
        if @response.save
          next
        end
      end
    elsif params[:response][:response_type] == "1"
      params[:response][:question_id].each do | question_id |
        @response = Response.new(response_params)
        @response.user_id = current_user.id
        @response.answer_id = params[:response]["answer_id"]["#{question_id.first}"]
        @response.question_id = question_id.first
        @response.response_type = params[:response][:response_type]
        @response.questionnaire_id = params[:response][:questionnaire_id]
        if @response.save
          next
        else
          respond_to do |format|
            format.html { redirect_to questionnaires_path, notice: "Respuestas no guardadas" }
            format.json { render :show, status: :created, location: @response }
          end
        end

      end
    end

    respond_to do |format|
      format.html { redirect_to questionnaires_path, notice: "Respuestas enviadas" }
      format.json { render :show, status: :created, location: @response }
    end

  end

  # PATCH/PUT /responses/1 or /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to show_responses_path(@response.questionnaire_id), notice: "Respuestas enviadas" }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1 or /responses/1.json
  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to responses_url, notice: "Response was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def response_params
      params.require(:response).permit(
        :question_id,
        :answer_id,
        :user_id,
        :points,
        :response_type,
        :audio_response,
        :questionnaire_id
      )
    end
end
