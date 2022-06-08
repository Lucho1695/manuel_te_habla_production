class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /people or /people.json
  def index
    if current_user.user_roles== "SuperAdmin"
      @people = Person.all.order("email")
      @childrens = []
    elsif current_user.user_roles== "Adulto Responsable"
      @people = Person.where(id: current_user.id)
      @childrens = Person.where(user_id: current_user.id)
    else
      redirect_to categories_path
    end
  end

  # GET /people/1 or /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people or /people.json
  def create
    @person = Person.new(person_params)
    if current_user.user_roles== "Adulto Responsable"
      @person.user_id = current_user.id
    end
    respond_to do |format|
      if @person.save
        format.html { redirect_to people_path, notice: "Person was successfully created." }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1 or /people/1.json
  def update
    respond_to do |format|
    if params[:person]["password"] != @person.password && params[:person]["password"].chars.count >= 6
      @person.update(password: params[:person]["password"])
      User.find(@person.id).update(password: params[:person]["password"])
      if current_user.id == @person.id
        format.html { redirect_to destroy_user_session_path, notice: "Se ha modificado su contraseña." }
      else
        format.html { redirect_to people_path, notice: "La persona a sido editada exitosamente." }
        format.json { render :show, status: :ok, location: people_path }
      end
    else
      if @person.update(person_params)
        format.html { redirect_to people_path, notice: "La persona a sido editada exitosamente." }
        format.json { render :show, status: :ok, location: people_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # DELETE /people/1 or /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: "Person was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:name, :photo, :status, :roles,
        :comments, :email, :password, :avatar
      )
    end
end
