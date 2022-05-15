class LevelAssignmentsController < ApplicationController
  before_action :set_level, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /levels or /levels.json
  def index
    @level_assignments = LevelAssignment.all
  end

  # GET /levels/1 or /levels/1.json
  def show
  end

  # GET /levels/new
  def new
    @level_assignment = LevelAssignment.new
  end

  # GET /levels/1/edit
  def edit
  end

  # POST /levels or /levels.json
  def create
    @level_assignment = LevelAssignment.new(level_params)
    level_ids = params[:level_assignment][:level].reject{ | m | m if m.empty?}
    person_ids = params[:level_assignment][:person].reject{ | m | m if m.empty?}
    @level_assignment.level = level_ids
    @level_assignment.person = person_ids

    respond_to do |format|
      if @level_assignment.save
        format.html { redirect_to @level_assignment, notice: "LevelAssignment was successfully created." }
        format.json { render :show, status: :created, location: @level_assignment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @level_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /levels/1 or /levels/1.json
  def update
    level_ids = params[:level_assignment][:level].reject{ | m | m if m.empty?}.collect{|k| k.to_i if !k.nil?}
    person_ids = params[:level_assignment][:person].reject{ | m | m if m.empty?}.collect{|k| k.to_i if !k.nil?}
    @level_assignment.level = level_ids
    @level_assignment.person = person_ids
    respond_to do |format|
      if @level_assignment.update(level_params)
        format.html { redirect_to @level_assignment, notice: "LevelAssignment was successfully updated." }
        format.json { render :show, status: :ok, location: @level_assignment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @level_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /levels/1 or /levels/1.json
  def destroy
    @level_assignment.destroy
    respond_to do |format|
      format.html { redirect_to levels_url, notice: "LevelAssignment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_level
      @level_assignment = LevelAssignment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def level_params
      params.require(:level_assignment).permit(:time_start, :time_end, :level, :person, :active)
    end
end
