class AddUsersToSayIdeas < ActiveRecord::Migration[5.2]
  def change
    add_column :say_ideas, :users, :json
  end
end
