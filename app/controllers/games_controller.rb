class GamesController < ApplicationController
  def index
    record_activity("Ingreso a juegos")
  end

  def puzzle
    record_activity("Ingreso al rompecabezas")
    @categories = Category.where(public: true) if current_user.nil?
    if !current_user.nil?
      @categories = []
      Category.all.each do | category |
        if !category.users.nil?
          @categories << category if category.users["ids"].flatten.include?("#{current_user.id}")
        end
      end
    end
  end

  def puzzle_category
    @image = Subcategory.find(params[:id])
  end

  def memory
    if !current_user.nil?
      record_activity("Ingreso al memoria")
      person = Person.find_by(email: current_user.email)
      categories = Category.where.(creator_id: current_user.id)
      @subcategories = []
      Subcategory.where(category_id: categories.ids).sample(6).each do | subcategory |
        if subcategory.subcategories_image.attached?
          @subcategories << subcategory
        end
      end
    else
      @ids = []
    end

  end

  def memory_log
    data = {
      time: params[:text].squish,
      status: "Completado"
    }
    record_activity_with_more_info("Completó el juego de memoria", data)
  end

  def puzzle_log
    data = {
      time: params[:text].squish,
      status: "Completado"
    }
    record_activity_with_more_info("Completó el juego del rompecabezas", data)
  end
end
