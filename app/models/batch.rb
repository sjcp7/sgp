class Batch < ApplicationRecord
  belongs_to :course
  belongs_to :school_year
  belongs_to :school_grade
  belongs_to :batch_director, class_name: "Teacher", optional: true
  has_many :course_subjects, through: :course
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :lectures
  has_many :tests, through: :lectures
  has_many :teachers, through: :lectures

  accepts_nested_attributes_for :lectures

  def self.fetch_with_teacher(teacher)
    Batch.all.filter do |b|
      b.lectures.find_by(teacher: teacher)
    end    
  end
end
