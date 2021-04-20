class Teacher < ApplicationRecord
  has_one :user, as: :profile
  has_many :lectures
  has_many :batches, through: :lectures
  has_many :course_subjects, through: :lectures
  has_many :requests
  accepts_nested_attributes_for :user

  def full_name
    "#{first_name} #{last_name}"
  end
end
