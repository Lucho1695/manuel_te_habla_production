class CreateGroupUserPeople < ActiveRecord::Migration[6.0]
  def change
    create_table :group_user_people do |t|
      t.bigint :user_id
      t.bigint :person_id

      t.timestamps
    end
  end
end
