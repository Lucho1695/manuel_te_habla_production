class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true
  mount_uploader :avatar, FilesUploader

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  enum user_roles: {
    "SuperAdmin": 0,
    "Adulto Responsable": 1,
    "Niño": 2
  }

  has_many :level_assignments
  has_many :people, through: :level_assignments

end
