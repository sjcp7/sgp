class Student < ApplicationRecord
  has_many :enrollments
  has_many :batches, through: :enrollments
  has_many :tests
end
