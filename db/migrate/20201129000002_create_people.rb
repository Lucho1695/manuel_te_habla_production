class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.boolean :status, default: true
      t.integer :roles, default: 2
      t.json :comments
      t.references :user
      t.string :email
      t.string :password
      t.integer :user_role

      t.timestamps
    end
    add_foreign_key :people, :users, column: :user_id, primary_key: :id
    add_index :people, :name
    add_index :people, :email,                unique: true

  end
end
