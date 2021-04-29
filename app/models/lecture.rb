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
  has_one :batch_director, through: :batch

  after_create :create_tests

  scope :find_by_teacher, ->(teacher) { where(teacher: teacher) }
  

  private

  def create_tests
    students = self.students
    s_quarters = SchoolQuarter.all
    third_quarter = ['MAD', 'EX', 'CF']
    locked_kinds = ['PP', 'PT']
    general_kinds = Test.kinds.values - ['AC'] - third_quarter - locked_kinds
    create_regular_tests(students: students, kinds: general_kinds, quarters: s_quarters)
    create_locked_tests(students: students, kinds: locked_kinds, quarters: s_quarters)
    create_locked_tests(students: students, kinds: third_quarter, quarter: s_quarters.third)
  end

  def create_regular_tests(options)
    options[:students].each do |student|
      options[:kinds].each do |kind|
        options[:quarters].each do |quarter|
          create_test(student, quarter, kind, false)
        end
      end
    end
  end

  def create_locked_tests(options)
    options[:students].each do |student|
      options[:kinds].each do |kind|
        if options[:quarter]
          create_test(student, options[:quarter], kind, true)
        else
          options[:quarters].each do |quarter|
            create_test(student, quarter, kind, true)
          end
        end
      end
    end
  end

  def create_test(student, quarter, kind, locked)
    new_test = self.tests.find_or_create_by(school_quarter: quarter, kind: kind, max_score: 20, locked: locked)
    student.student_tests.create(test: new_test, score: 0)
  end
end
