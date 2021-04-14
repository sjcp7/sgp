class Batch < ApplicationRecord
  belongs_to :course
  belongs_to :school_year
  belongs_to :school_grade
  has_many :enrollments
  has_many :students, through: :enrollments
end
