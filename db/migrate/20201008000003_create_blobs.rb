class CreateBlobs < ActiveRecord::Migration[5.2]
  def change
    create_table :blobs do |t|
    end
    execute 'ALTER TABLE blobs ADD COLUMN data MEDIUMBLOB'
  end
end
