class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy, :show_upload_file]

  # GET /videos
  # GET /videos.json
  def index
    record_activity("Ingreso a video")
    if !current_user.nil?
      if current_user.user_roles == "SuperAdmin"
        @videos= Video.all
      elsif current_user.user_roles == "Adulto Responsable"
        @videos = Video.where(creator_id: current_user.id)
      elsif current_user.user_roles == "Niño"
        person = Person.find_by(email: current_user.email)
        @videos = Video.where(creator_id: person.user_id)
      end
    else
      @videos = []
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    if !current_user.nil?
    else
      redirect_to users_url
    end
  end

  # GET /videos/new
  def new
    if !current_user.nil?
      @video = Video.new
      @video.upload_files.build
    else
      redirect_to users_url
    end
  end

  # GET /videos/1/edit
  def edit
    if !current_user.nil?
    else
      redirect_to users_url
    end
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    @video.creator_id = current_user.id
    if @video
      respond_to do |format|
        if @video.save
          format.html { redirect_to videos_url, notice: 'El Video ha sido guardado exitosamente.' }
          format.json { render :show, status: :created, location: @video }
        else
          format.html { render :new }
          format.json { render json: @video.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to videos_url, notice: 'El Video ha sido guardado exitosamente.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_upload_file
    send_data @video.upload_files.first.blob.data,
      filename: @video.upload_files.first.filename,
      type: @video.upload_files.first.content_type,
      disposition: 'inline'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:title, :description, :url, :creator_id,
        upload_files_attributes: [
          :id,
          :upload_file,
          :video_id,
          :_destroy
        ],
      )
    end
end
