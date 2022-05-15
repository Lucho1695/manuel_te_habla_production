class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.belongs_to :question, null: false, foreign_key: true
      t.string :name
      t.string :answer_file

      t.timestamps
    end
  end
end
