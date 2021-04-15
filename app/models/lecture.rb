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
    students = self.students
    s_quarters = SchoolQuarter.all
    kinds = Test.kinds.values
    exceptions = ['AC', 'MAD', 'EX', 'CF']
    create_regular_tests(students: students, kinds: kinds, quarters: s_quarters, exceptions: exceptions, lecture: self)
    create_exception_tests(students: students, kinds: kinds, quarter: s_quarters.last, exceptions: exceptions, lecture: self)
  end

  def create_regular_tests(options)
    options[:students].each do |student|
      options[:kinds].each do |kind|
        options[:quarters].each do |quarter|
          unless kind.in?(options[:exceptions])
            test = options[:lecture].tests.create(school_quarter: quarter, kind: kind, max_score: 20)
            student.student_tests.create(test: test, score: 0)
          end
        end
      end
    end
  end

  def create_exception_tests(options)
    options[:students].each do |student|
      options[:kinds].each do |kind|
        if kind.in?(options[:exceptions]) && kind != 'AC'
          test = options[:lecture].tests.create(school_quarter: options[:quarter], kind: kind, max_score: 20)
          student.student_tests.create(test: test, score: 0)
        end
      end
    end
  end
end
