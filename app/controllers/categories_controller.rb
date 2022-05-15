class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :show_small_category_image,
    :show_category_themes, :edit, :update, :destroy
  ]

  # GET /categories
  # GET /categories.json
  def index
    if current_user.nil?
      record_activity("Ingreso a categorías")
      @categories = Category.where(public: true)
    else
      record_activity("Ingreso a categorías")
      case !current_user.nil?
      when current_user.user_roles == "Adulto Responsable"
        @categories = Category.where(creator_id: current_user.id)
      when current_user.user_roles == "Niño"
        @categories = []
        Category.all.each do | category |
          if !category.users.nil?
            @categories << category if category.users["ids"].flatten.include?("#{current_user.id}")
          end
        end
      when current_user.user_roles == "SuperAdmin"
        @categories = Category.all
      end
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
    if current_user.user_roles == "SuperAdmin"
      @users = User.where(user_roles: "Niño").ids
    elsif current_user.user_roles == "Adulto Responsable"
      @users = []
      Person.where(user_id: current_user.id).each do | person |
        @users << User.find_by(email: person.email).id
      end
    end
  end

  # GET /categories/1/edit
  def edit
    if current_user.user_roles == "SuperAdmin"
      @users = User.where(user_roles: "Niño").ids
    elsif current_user.user_roles == "Adulto Responsable"
      @users = []
      Person.where(user_id: current_user.id).each do | person |
        @users << User.find_by(email: person.email).id
      end
    end
    @ids = @category.users["ids"].flatten

  end


  # POST /categories
  # POST /categories.json
  def create
    @users = []
    Person.where(user_id: current_user.id).each do | person |
      @users << User.find_by(email: person.email).id
    end
    @category = Category.new(category_params)
    @category.creator_id = current_user.id
    if !params[:category][:users].empty?
      params[:category][:users].delete("")
      @category.users = { ids: [params[:category][:users]] }
    end
    respond_to do |format|
      if @category.save
        @category.category_image = "#{@category.id}"
        @category.save!

        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @users = []
    Person.where(user_id: current_user.id).each do | person |
      @users << User.find_by(email: person.email).id
    end
    if !params[:category][:users].empty?
      params[:category][:users].delete("")
      @category.users = {ids: [params[:category][:users]] }
    end
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.theme_files.each do | theme |
      theme.destroy
    end
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_small_category_image
    if  @category.image_files.first.is_image?
      send_data @category.image_files.first.get_thumb_nail(250, 250).to_blob,
        filename: @category.image_files.first.filename,
        type: "image/png",
        disposition: 'inline'
    else
      image = Magick::Image.new(70, 70){ self.background_color= "#AAA"}
      image.format = "PNG"
      send_data image.to_blob,
        filename: "#{@category.image_files.first.id.to_s}_thumb.png",
        type: "image/png",
        disposition: 'inline'
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name,
        :category_image,
        :public,
        :users,
        :creator_id,
        subcategories_attributes: [
          :id,
          :title,
          :category_id,
          :subcategories_image,
          :article_id,
          :_destroy
        ]
      )
    end
end
