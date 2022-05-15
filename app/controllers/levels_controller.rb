class LevelsController < ApplicationController
  before_action :set_level, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /levels or /levels.json
  def index
    @levels = Level.all
  end

  # GET /levels/1 or /levels/1.json
  def show
    @people = Person.all
  end

  # GET /levels/new
  def new
    if current_user.user_roles== "SuperAdmin"
      @level = Level.new
    else
      redirect_to levels_path
    end
  end

  # GET /levels/1/edit
  def edit
    @level_assignments = @level.people.build
  end

  # POST /levels or /levels.json
  def create
    @level = Level.new(level_params)
    respond_to do |format|
      if @level.save
        params[:level_assignments_attributtes][:person_id].each do | person_id |
          if person_id.empty?
            next
          else
            level_assignment = @level.level_assignments.build
            level_assignment.person_id = person_id
            level_assignment.save!
          end
        end
        format.html { redirect_to @level, notice: "Nivel creado satisfactoriamente." }
        format.json { render :show, status: :created, location: @level }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /levels/1 or /levels/1.json
  def update
    respond_to do |format|
      if @level.update(level_params)
        format.html { redirect_to @level, notice: "Nivel actualizado satisfactoriamente." }
        format.json { render :show, status: :ok, location: @level }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /levels/1 or /levels/1.json
  def destroy
    @level.destroy
    respond_to do |format|
      format.html { redirect_to levels_url, notice: "Nivel eliminado satisfactoriamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_level
      @level = Level.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def level_params
      params.require(:level).permit(:name, :comment,
        level_assignments_attributtes: [
          :id,
          :person_id,
          :_destroy
        ]
      )
    end
end
