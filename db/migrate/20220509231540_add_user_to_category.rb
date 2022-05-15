class AddUserToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :users, :json
    add_reference :categories, :creator
    add_reference :videos, :creator
    add_reference :say_ideas, :creator
    add_reference :questionnaires, :creator
    add_foreign_key :categories, :users, column: :creator_id, primary_key: :id
    add_foreign_key :say_ideas, :users, column: :creator_id, primary_key: :id
    add_foreign_key :videos, :users, column: :creator_id, primary_key: :id
    add_foreign_key :questionnaires, :users, column: :creator_id, primary_key: :id
  end

end
