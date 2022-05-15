class UserLog < ApplicationRecord
  belongs_to :user, optional: true
  has_many :user_log_withs

end
