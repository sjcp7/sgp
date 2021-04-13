class Batch < ApplicationRecord
  belongs_to :course
  belongs_to :school_year
  belongs_to :school_grade
end
