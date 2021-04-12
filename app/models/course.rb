class Course < ApplicationRecord
  enum kind: { puniv: 'PUNIV', technical: 'Técnico' }
  has_many :course_subjects
  has_many :subjects, through: :course_subjects
end
