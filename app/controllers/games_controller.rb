class GamesController < ApplicationController
  def index
    record_activity("Ingreso a juegos")
  end

  def puzzle
    record_activity("Ingreso al rompecabezas")
    @categories = Category.where(public: true) if current_user.nil?
    @categories = Category.all if !current_user.nil?
  end

  def puzzle_category
    @image = Subcategory.find(params[:id])
  end

  def memory
    if !current_user.nil?
      record_activity("Ingreso al memoria")
      person = Person.find_by(email: current_user.email)
      categories = Category.where(creator_id: person.user_id)

      @ids = Subcategory.where(category_id: categories.ids).ids.sample(7)
      @names = Subcategory.find(@ids).pluck(:title)
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
