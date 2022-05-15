class AddSayIdeaImageToSayIdeas < ActiveRecord::Migration[6.0]
  def change
    add_column :say_ideas, :say_idea_image, :string
  end
end
