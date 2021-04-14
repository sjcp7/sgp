class Subject < ApplicationRecord
  has_many :course_subjects
  has_many :courses, through: :course_subjects
  has_many :enrollments
  has_many :batches, through: :enrollments

  def self.in_course(course)
    in_course = {}
    set_hash(in_course)
    course.course_subjects.each do |cs|
      in_course[cs.school_grade.grade] << cs.subject
    end
    in_course
  end

  def self.not_in_course(course)
    not_in_course = {}
    set_hash(not_in_course)
    in_course(course).each do |grade, subjects_array|
      not_in_course[grade] = Subject.all - subjects_array
    end
    not_in_course
  end

  private

  def self.set_hash(hash)
    SchoolGrade.all.each do |grade|
      hash[grade.grade] = []
    end
  end
end
