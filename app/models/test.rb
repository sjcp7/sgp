class Test < ApplicationRecord
  belongs_to :lecture
  belongs_to :school_quarter
  has_one :teacher, through: :lecture
  has_one :course_subject, through: :lecture
  has_one :school_grade, through: :course_subject
  has_one :course, through: :course_subject
  has_one :school_year, through: :lecture
  has_many :student_tests, dependent: :destroy
  has_many :students, through: :student_tests
  has_one :batch, through: :lecture
  has_one :batch_director, through: :batch
  has_one :subject, through: :lecture
  has_many :requests

  accepts_nested_attributes_for :student_tests
  after_update :update_student_tests

  enum kind: {
    AC: 'AC',
    MAC: 'MAC',
    PP: 'PP',
    PT: 'PT',
    MT: 'MT',
    MAD: 'MAD',
    EX: 'EX',
    CF: 'CF'
  }

  scope :find_by_school_quarter, ->(sq) { where(school_quarter: sq) }
  scope :score, ->{ student_tests.first.score }
  scope :find_by_lecture, ->(lecture) { where(lecture: lecture) }


  private

  def update_student_tests
    if self.AC?
      self.student_tests.each { |st| st.update_student_tests }
    end
  end
end
