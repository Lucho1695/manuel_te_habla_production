class UserLogWith < ApplicationRecord
  belongs_to :user_log, foreign_key: 'user_log_id'
end
