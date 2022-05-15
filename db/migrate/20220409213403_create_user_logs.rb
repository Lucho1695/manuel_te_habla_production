class CreateUserLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_logs do |t|
      t.references :user, foreign_key: true
      t.string :ip_address
      t.string :controller
      t.string :action
      t.string :note
      t.string :browser
      t.boolean :have_more_description, default: false
      t.string :params

      t.timestamps
    end
  end
end
