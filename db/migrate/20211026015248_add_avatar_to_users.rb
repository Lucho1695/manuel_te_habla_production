class AddAvatarToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatar, :string
    add_column :people, :avatar, :string
  end
end
