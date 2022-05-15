class UsersController < ApplicationController
  before_action :set_user, only: [:show, :show_small_image, :edit, :update, :destroy]#, :update, :publish, :unpublish]
  before_action :authenticate_user!

  def index
    if current_user.user_roles== "SuperAdmin"
      @users = User.all.order("email")
    elsif current_user.user_roles== "Adulto Responsable"
      @users = [current_user]
    else
      redirect_to categories_path
    end
  end

  def new
    @user = User.new
  end

  def edit
    respond_to do | format |
      format.html { render :action => :edit }
    end
  end

  def create
    @user = User.new
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to action: "categories", notice: 'User was successfully created.' }
      end
    end
  end
  #Ends create action

  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?

    respond_to do |format|
      if @user.errors[:base].empty? and @user.update_attributes(user_params) #@user.update_attributes(params[:user])
        format.json { render :json => @user.to_json, :status => 200 }
        format.xml  { head :ok }
        #format.html { render :action => :index }
        format.html { redirect_to :user }
      else
        format.json { render :text => "Could not update user", :status => :unprocessable_entity } #placeholder
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.html { render :action => :edit, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_to do | format |
      format.html { render :show }
    end
  end

  # def destroy
  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to users_url, notice: 'Usuario retirado con exito' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def show_small_image
    if  @user.upload_files.first.is_image?
      send_data @user.upload_files.first.get_thumb_nail(250, 250).to_blob,
        filename: @user.upload_files.first.filename,
        type: "image/png",
        disposition: 'inline'
    else
      image = Magick::Image.new(70, 70){ self.background_color= "#AAA"}
      image.format = "PNG"
      send_data image.to_blob,
        filename: "#{@user.upload_files.first.id.to_s}_thumb.png",
        type: "image/png",
        disposition: 'inline'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :name,
      :user_roles,
      :avatar
    )
  end
end
