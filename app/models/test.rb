class Test < ApplicationRecord
  belongs_to :student
  belongs_to :lecture
  belongs_to :school_quarter
  has_one :teacher, through: :lecture
  has_one :course_subject, through: :lecture
  has_one :school_grade, through: :course_subject
  has_one :school_year, through: :lecture

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
end
