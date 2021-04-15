class Student < ApplicationRecord
  has_many :enrollments
  has_many :batches, through: :enrollments
  has_many :student_tests
  has_many :tests, through: :student_tests

  def full_name
    "#{first_name} #{last_name}" 
  end
end
