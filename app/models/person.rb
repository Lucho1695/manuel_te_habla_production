class Person < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id", optional: true

  has_many :level_assignments, class_name: 'LevelAssignment'
  has_many :levels, through: :level_assignments

  accepts_nested_attributes_for :levels, reject_if: :all_blank, allow_destroy: true

  validates :email, presence: true
  validates_format_of :email, :with => Devise::email_regexp
  validates :password, presence: true, length: {minimum: 6, maximum: 256}

  mount_uploader :avatar, FilesUploader

  after_save :create_user

  enum user_roles: {
    "SuperAdmin": 0,
    "Adulto Responsable": 1,
    "Niño": 2
  }

  def create_user
    if self.email != nil && self.name != nil && self.roles !=nil && self.password != nil
      user = User.where(id: self.id).first
      if user.nil?
        user = User.new
        if self.id == 0
          user.id = self.id
        end
        user.avatar = self.avatar
        user.email = self.email
        user.user_roles = self.roles.to_i
        user.name = self.name
        user.password = self.password
        user.save
      else
        user.update(
          avatar: "#{self.id}",
          email: self.email,
          user_roles: self.roles.to_i,
          name: self.name
        )
      end
    end
  end


end
