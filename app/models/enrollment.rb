class Enrollment < ApplicationRecord
  belongs_to :batch
  belongs_to :student

  after_create :create_student_tests

  private

  def create_student_tests
    self.batch.lectures.each do |lecture|
      lecture.create_tests([self.student])
    end
  end
end
