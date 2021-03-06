class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :questionnaire, null: false, foreign_key: true
      t.string :name
      t.integer :question_type
      t.boolean :required

      t.timestamps
    end
  end
end
