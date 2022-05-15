class AddSayIdeaImageToSayIdeas < ActiveRecord::Migration[5.2]
  def change
    add_column :say_ideas, :say_idea_image, :string
  end
end
