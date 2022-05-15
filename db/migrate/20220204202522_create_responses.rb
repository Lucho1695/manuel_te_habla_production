class CreateResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.references :question
      t.references :answer
      t.references :user
      t.float :points

      t.timestamps
    end
  end
end
