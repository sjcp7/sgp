class StudentTest < ApplicationRecord
  belongs_to :test
  belongs_to :student

  after_update :update_student_tests

  def update_student_tests
    if self.test.AC?
      update_MAC
    elsif self.test.PP? || self.test.PT?
      update_MT
    end
  end

  private

  def update_MAC
    sq = self.test.school_quarter
    tests = self.student.tests
    mac = tests.MAC.find_by_school_quarter(sq).first.student_tests.where(student: self.student).first
    acs = tests.AC.find_by_school_quarter(sq).map do |ac|
      ac_test = ac.student_tests.where(student: self.student).first
      if ac_test.test.max_score == 5
        ac_test.score * 4
      elsif ac_test.test.max_score == 10
        ac_test.score * 2
      end
    end
    average = acs.reduce(:+) / acs.size
    mac.update(score: average) 
  end

  def update_MT
  end
end
