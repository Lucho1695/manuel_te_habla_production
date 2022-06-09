class ChartsController < ApplicationController
  before_action :authenticate_user!

  def goals
    users = User.where(email: Person.where(user_id: current_user.id).pluck(:email))  if current_user.user_roles == "Adulto Responsable"
    users = Person.where(roles: 2) if current_user.user_roles == "SuperAdmin"

    responses = Response.where(user_id: users.ids)
    @cuestionarios = []
    responses.each do | response |
      if !response.questionnaire_id.nil?
        @cuestionarios << response.questionnaire
      end
    end
    @cuestionarios = @cuestionarios.uniq
  end

  def show_goals
    @cuestionario = Questionnaire.find(params[:goal_id])

    if !params[:filter].nil?
      @users = params[:get][:person_id]
      @question = params[:get][:question_id]
      case !params[:filter].nil?
      when !params[:get][:person_id].join.empty? && params[:get][:question_id].join.empty?
        users = User.where(id: params[:get][:person_id])
        responses = Response.where(user_id: users.ids, questionnaire_id: params[:goal_id])
      when params[:get][:person_id].join.empty? && params[:get][:question_id].join.empty?
        users = User.where(user_id: current_user.id) if current_user.user_roles == "Adulto Responsable"
        users = User.where(user_roles: 2) if current_user.user_roles == "SuperAdmin"
        responses = Response.where(user_id: users.ids, questionnaire_id: params[:goal_id])
      when !params[:get][:question_id].join.empty? && params[:get][:person_id].join.empty?
        users = User.where(user_id: current_user.id) if current_user.user_roles == "Adulto Responsable"
        users = User.where(user_roles: 2) if current_user.user_roles == "SuperAdmin"
        responses = Response.where(user_id: users.ids, question_id: params[:get][:question_id])
      when params[:get][:person_id].join.empty? && !params[:get][:question_id].join.empty?
        users = User.where(user_id: current_user.id) if current_user.user_roles == "Adulto Responsable"
        users = User.where(user_roles: 2) if current_user.user_roles == "SuperAdmin"
        responses = Response.where(user_id: users.ids, question_id: params[:get][:question_id])
      when !params[:get][:person_id].join.empty? && !params[:get][:question_id].join.empty?
        users = User.where(id: params[:get][:person_id])
        responses = Response.where(user_id: users.ids, question_id: params[:get][:question_id], questionnaire_id: params[:goal_id])
      else
        users = User.where(user_id: current_user.id) if current_user.user_roles == "Adulto Responsable"
        users = User.where(user_roles: 2) if current_user.user_roles == "SuperAdmin"
        responses = Response.where(user_id: users.ids, questionnaire_id: params[:goal_id])
      end
    else
      users = User.where(email: Person.where(user_id: current_user.id).pluck(:email))  if current_user.user_roles == "Adulto Responsable"
      users = Person.where(roles: 2) if current_user.user_roles == "SuperAdmin"

      responses = Response.where(user_id: users.ids, questionnaire_id: params[:goal_id])
    end

    if !responses.nil?
      @data = []
      users.each do | user |
        @data << {name: user.name, results: []}
      end
      @data.each do | da |
        responses.each do | response |
          if da[:name] == response.user.name
            da[:results] << { name: response.user.name + ", " + response.created_at.strftime("%d/%m/%Y"), data: []}
          end
          da[:results] = da[:results].uniq
        end

        responses.order(:created_at).each do | response |
          if da[:name] == response.user.name
            if !response.points.nil? && !response.question_id.nil? && !response.user_id.nil? && !response.questionnaire_id.nil?
              da[:results].each do | result |
                if result[:name] == response.user.name + ", " + response.created_at.strftime("%d/%m/%Y")
                  result[:data] << [response.question.name, response.points]
                end
              end
            end
          end
        end
      end
    end

  end


  def timelines
    if !params[:filter].nil?
      if !params[:get][:person_id].empty? && params[:get][:user_log_id].empty?
        @user_logs = UserLog.where(user_id: params[:get][:person_id])
      elsif !params[:get][:user_log_id].empty? && params[:get][:person_id].empty?
        @user_logs = UserLog.where(note: params[:get][:user_log_id]) if current_user.user_roles == "SuperAdmin"
        @user_logs = UserLog.where(user_id: Person.where(user_id: current_user.id).ids, note: params[:get][:user_log_id]) if current_user.user_roles == "Adulto Responsable"
      elsif !params[:get][:user_log_id].empty? && !params[:get][:person_id].empty?
        @user_logs = UserLog.where(user_id: params[:get][:person_id], note: params[:get][:user_log_id])
      else
        return @user_logs = "No hay data"
      end
    else
      @user_logs = UserLog.all if current_user.user_roles == "SuperAdmin"
      @user_logs = UserLog.where(user_id: User.where(email: Person.where(user_id: current_user.id).pluck(:email)).ids) if current_user.user_roles == "Adulto Responsable"
    end
    users = []
    @user_logs.last(200).each do | user_log |
      if user_log.user.nil?
        users << user_log.ip_address
      else
        users << user_log.user.name
      end
    end
    @users = users.uniq
  end

  def childs
    if current_user.user_roles == "SuperAdmin"
      @people = {}
      @people[:SuperAdmin] = Person.where(roles: 0).count
      @people[:AdultoResponsable] = Person.where(roles: 1).count
      @people[:Niño] = Person.where(roles: 2).count
    else
      redirect_to(categories_path, alert: "Acceso denegado.")

    end
  end

  def categories
    @categories = {}
    @categories[:public] = Category.where(public: true).count
    @categories[:not_public] = Category.where(public: false).count
  end

  def user_logs
    user_log = UserLog.find(params[:user_log_id])
    user_log_withs = user_log.user_log_withs
    user = user_log.user
    render json: {user_log: user_log, user: user, user_log_withs: user_log_withs }
  end
end
