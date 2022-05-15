class CreateGroupUserPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :group_user_people do |t|
      t.bigint :user_id
      t.bigint :person_id

      t.timestamps
    end
  end
end
