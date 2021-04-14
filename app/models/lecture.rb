class Lecture < ApplicationRecord
  belongs_to :course_subject
  belongs_to :batch
  belongs_to :teacher
  has_one :school_year, through: :batch
  has_many :students, through: :batch
  has_one :school_grade, through: :course_subject
  has_one :subject, through: :course_subject
  has_one :course, through: :course_subject
  has_many :tests

  after_create :create_tests

  private

  def create_tests
    self.students.each do |student|
      Test.kinds.keys.each do |kind|
        SchoolQuarter.all.each do |sq|
          unless kind == 'AC'
            student.tests.create(
              lecture: self, score: 0, max_score: 20, school_quarter: sq, kind: kind
            )
          end
        end
      end
    end
  
  end
end
