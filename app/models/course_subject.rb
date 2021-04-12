class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject
  belongs_to :school_grade
end
