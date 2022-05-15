class CreateUserLogWiths < ActiveRecord::Migration[6.0]
  def change
    create_table :user_log_withs do |t|
      t.references :user_log, null: false, foreign_key: true
      t.json :data

      t.timestamps
    end
  end
end
