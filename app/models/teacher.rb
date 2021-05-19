class Teacher < ApplicationRecord
  has_one :user, as: :profile, dependent: :destroy
  has_many :lectures, dependent: :nullify
  has_many :batches, through: :lectures
  has_many :managed_batches, class_name: 'Batch', foreign_key: :batch_director, dependent: :nullify
  has_many :course_subjects, through: :lectures
  has_many :requests
  accepts_nested_attributes_for :user

  def full_name
    "#{first_name} #{last_name}"
  end
end
