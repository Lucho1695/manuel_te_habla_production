class AddFatherToSayIdeas < ActiveRecord::Migration[6.0]
  def change
    add_reference :say_ideas, :say_ideas, default: nil
  end
end
