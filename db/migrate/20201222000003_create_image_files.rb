class CreateImageFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :image_files do |t|
      t.string :filename
      t.string :content_type
      t.integer :file_size
      t.boolean :principal_file, default: false
      t.integer :category_id, null: false, default: -1
      t.integer :blob_id, null: false, default: -1
      t.boolean :deleted, null: false, default: false
      t.timestamps null: false
    end
    add_index :image_files, :category_id
    add_index :image_files, :blob_id
    add_index :image_files, :deleted
    add_index :image_files, :filename
  end
end
