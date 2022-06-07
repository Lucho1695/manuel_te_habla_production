class Video < ApplicationRecord

  before_save :save_url

  has_many :upload_files

  accepts_nested_attributes_for :upload_files,
  allow_destroy: true, reject_if: lambda { |a| a[:upload_file].blank? }

  def save_url
    if !self.url.nil?
      values = self.url.split("/")
      if values.last.split("watch?v=").count != 1
        values = values.last.split("watch?v=").last
      else
        values = values.last
      end
      self.url = "https://www.youtube.com/embed/" + values
    end
  end

end
