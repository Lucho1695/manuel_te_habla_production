class CreateUploadFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :upload_files do |t|
      t.string :filename
      t.string :content_type
      t.string :sub_title
      t.integer :file_size
      t.boolean :principal_file, default: false
      t.references :category
      t.references :blob
      t.references :person
      t.references :video
      t.references :say_idea
      t.references :user
      t.boolean :deleted, null: false, default: false
      t.timestamps null: false
    end

    add_foreign_key :upload_files, :say_ideas, column: :say_idea_id, primary_key: :id
    add_foreign_key :upload_files, :categories, column: :category_id, primary_key: :id
    add_foreign_key :upload_files, :people, column: :person_id, primary_key: :id
    add_foreign_key :upload_files, :blobs, column: :blob_id, primary_key: :id
    add_foreign_key :upload_files, :videos, column: :video_id, primary_key: :id
    add_foreign_key :upload_files, :users, column: :user_id, primary_key: :id
    add_index :upload_files, :deleted
    add_index :upload_files, :filename
  end
end
