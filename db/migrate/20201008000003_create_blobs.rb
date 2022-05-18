class CreateBlobs < ActiveRecord::Migration[5.2]
  def change
    create_table :blobs do |t|
      t.column :data, :binary, :limit => 10.megabyte
    end
  end
end
