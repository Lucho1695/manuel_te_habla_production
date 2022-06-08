class SayIdeasController < ApplicationController
  before_action :set_say_idea, only: [:show, :edit, :update, :destroy]

  # GET /say_ideas
  # GET /say_ideas.json
  def index
    case !current_user.nil?
    when current_user.user_roles == "Adulto Responsable"
      @say_ideas = SayIdea.where(creator_id: current_user.id)
    when current_user.user_roles == "Niño"
      @say_ideas = []
      SayIdea.all.each do | say_idea |
        if !say_idea.users.nil?
          @say_ideas << say_idea if say_idea.users["ids"].flatten.include?("#{current_user.id}")
        end
      end
    when current_user.user_roles == "SuperAdmin"
      @say_ideas = SayIdea.all
    end
  end

  # GET /say_ideas/new
  def new
    @say_idea = SayIdea.new
    if current_user.user_roles == "SuperAdmin"
      @users = User.where(user_roles: "Niño").ids
    elsif current_user.user_roles == "Adulto Responsable"
      @users = []
      Person.where(user_id: current_user.id).each do | person |
        @users << User.find_by(email: person.email).id
      end
    end
  end

  # GET /say_ideas/1/edit
  def edit
    if current_user.user_roles == "SuperAdmin"
      @users = User.where(user_roles: "Niño").ids
    elsif current_user.user_roles == "Adulto Responsable"
      @users = []
      Person.where(user_id: current_user.id).each do | person |
        @users << User.find_by(email: person.email).id
      end
    end
    if !@say_idea.users.nil?
      @ids = @say_idea.users["ids"].flatten
    end
  end

  # POST /say_ideas or /say_ideas.json
  def create
    @say_idea = SayIdea.new(say_idea_params)
    @say_idea.creator_id = current_user.id
    if !params[:say_idea][:users].empty?
      params[:say_idea][:users].delete("")
      @say_idea.users = {ids: [params[:say_idea][:users]] }
    end
    respond_to do |format|
      if @say_idea.save
        format.html { redirect_to say_ideas_path, notice: "SayIdea was successfully created." }
        format.json { render :show, status: :created, location: @say_idea }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @say_idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /say_ideas/1 or /say_ideas/1.json
  def update
    if !params[:say_idea][:users].empty?
      params[:say_idea][:users].delete("")
      @say_idea.users = {ids: [params[:say_idea][:users]] }
    end
    respond_to do |format|
      if @say_idea.update(say_idea_params)
        format.html { redirect_to say_ideas_path, notice: "Person was successfully updated." }
        format.json { render :show, status: :ok, location: @say_idea }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @say_idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def verbs
    @last_idea = SayIdea.find(params[:id]).title
    @say_ideas = SayIdea.where(say_ideas_id: params[:id])
    # render json: {success: true, verbs: "#{verbs}", title: title }
  end

  def complement
    @last_idea = params[:last_idea]
    @last_verb = SayIdea.find(params[:id]).title
    @say_ideas = SayIdea.where(say_ideas_id: params[:id])
    # render json: {success: true, verbs: "#{verbs}", title: title }
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_say_idea
    @say_idea = SayIdea.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def say_idea_params
    params.require(:say_idea).permit(:title, :say_idea_type, :category_id, :creator_id,
      :article_id, :user_id, :say_idea_image, :say_ideas_id, :users
    )
  end
end
