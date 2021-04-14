class Batch < ApplicationRecord
  belongs_to :course
  belongs_to :school_year
  belongs_to :school_grade
  has_many :course_subjects, through: :course
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :lectures
  has_many :tests, through: :lectures
end
