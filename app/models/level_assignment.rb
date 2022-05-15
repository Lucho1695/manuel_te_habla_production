class LevelAssignment < ApplicationRecord
  belongs_to :level, class_name: 'Level'
  belongs_to :person, class_name: 'Person'

end
