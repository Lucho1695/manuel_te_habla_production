class AddFatherToSayIdeas < ActiveRecord::Migration[5.2]
  def change
    add_reference :say_ideas, :say_ideas, default: nil
  end
end
