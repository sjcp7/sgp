class Course < ApplicationRecord
  enum kind: { puniv: 'PUNIV', technical: 'Técnico' }
  
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :school_grades, through: :course_subjects
  has_many :batches
  accepts_nested_attributes_for :course_subjects, reject_if: :reject_course_subjects, allow_destroy: true
  after_create :create_batches, :create_lectures

  private

  def reject_course_subjects(attributes)
    attributes['subject_id'] == '0'
  end

  def create_batches
    self.school_grades.distinct.each do |sg|
      self.batches.create(school_grade: sg, school_year: SchoolYear.current.first, description: "#{self.acronymn + sg.grade.to_s }", batch_director: nil)
    end
  end

  def create_lectures
    self.course_subjects.each do |cs|
      CourseSubject.create_lectures(cs)
    end
  end
end
