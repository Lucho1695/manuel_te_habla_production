class CreateSubcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :subcategories do |t|
      t.string :title
      t.string :subcategories_image
      t.references :article
      t.belongs_to :category, null: false, foreign_key: true
      t.timestamps null: false
    end
    add_foreign_key :subcategories, :articles, column: :article_id, primary_key: :id
  end
end
