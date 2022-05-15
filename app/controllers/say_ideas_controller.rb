class SayIdeasController < ApplicationController
  before_action :set_say_idea, only: [:show, :edit, :update, :destroy]

  # GET /say_ideas
  # GET /say_ideas.json
  def index
    @say_ideas = SayIdea.all
  end

  # GET /say_ideas/new
  def new
    @say_idea = SayIdea.new
  end

  # GET /say_ideas/1/edit
  def edit
  end

  # POST /say_ideas or /say_ideas.json
  def create
    @say_idea = SayIdea.new(say_idea_params)
    @say_idea.creator_id = current_user.id

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
    params.require(:say_idea).permit(:title, :say_idea_type, :public, :category_id, :creator_id,
      :article_id, :user_id, :say_idea_image, :say_ideas_id
    )
  end
end
