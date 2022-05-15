class AddAudioResponseToResponses < ActiveRecord::Migration[6.0]
  def change
    add_column :responses, :audio_response, :longtext
    add_column :responses, :response_type, :integer
    add_reference :responses, :questionnaire
  end
end
