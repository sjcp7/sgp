class Student < ApplicationRecord
  has_many :enrollments
  has_many :batches, through: :enrollments
  has_many :tests

  def full_name
    "#{first_name} #{last_name}" 
  end
end
