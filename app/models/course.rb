class Course < ApplicationRecord
  enum kind: { puniv: 'PUNIV', technical: 'Técnico' }
  has_many :course_subjects
  has_many :subjects, through: :course_subjects
  accepts_nested_attributes_for :course_subjects, reject_if: :reject_course_subjects, allow_destroy: true

  private

  def reject_course_subjects(attributes)
    attributes['subject_id'] == '0'
  end
end
