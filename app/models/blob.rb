class Blob < ApplicationRecord
  # if all of these are nil, then the blob is a orphan zombie and should be deleted...
  has_one :upload_file

  def as_json()
    {id: self.id, data: Base64.encode64(self.data)}
  end

   def to_json()
     self.as_json.to_json
   end
end
