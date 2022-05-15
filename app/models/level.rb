class Level < ApplicationRecord
  has_many :level_assignments
  has_many :people, through: :level_assignments
  # has_many :level_assignments, class_name: 'LevelAssignment'
  # has_many :people, through: :level_assignments

end
