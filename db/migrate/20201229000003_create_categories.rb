class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :category_image
      t.boolean :public, default: false
      t.timestamps
    end
  end
end
