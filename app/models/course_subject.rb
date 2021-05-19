class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject
  belongs_to :school_grade
  has_many :lectures, dependent: :destroy
  
  def create_lectures(cs)
    SchoolGrade.all.each do |sg|
      cs.course.batches.each do |batch|
        cs.lectures.create(batch: batch, teacher: nil) if batch.school_grade == sg
      end
    end
  end
end
