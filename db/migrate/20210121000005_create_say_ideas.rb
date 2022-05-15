class CreateSayIdeas < ActiveRecord::Migration[5.2]
  def change
    create_table :say_ideas do |t|
      t.string :title
      t.integer :say_idea_type
      t.boolean :public
      t.references :category
      t.references :article
      t.references :user
      t.timestamps
    end
    add_foreign_key :say_ideas, :categories, column: :category_id, primary_key: :id
    add_foreign_key :say_ideas, :articles, column: :article_id, primary_key: :id
    add_foreign_key :say_ideas, :users, column: :user_id, primary_key: :id

  end
end
