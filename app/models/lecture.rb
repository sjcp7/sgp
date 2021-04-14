class Lecture < ApplicationRecord
  belongs_to :course_subject
  belongs_to :batch
  belongs_to :teacher
  has_one :school_year, through: :batch
  has_one :school_grade, through: :course_subject
end
