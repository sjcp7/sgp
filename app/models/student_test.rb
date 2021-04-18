class StudentTest < ApplicationRecord
  belongs_to :test
  belongs_to :student
  has_one :school_quarter, through: :test
  has_one :batch, through: :test
  has_one :subject, through: :test

  after_update :update_student_tests

  def update_student_tests
    sq = self.test.school_quarter
    tests = self.student.tests.where(lecture: self.test.lecture)
    if self.test.AC?
      update_MAC(sq, tests)
    elsif self.test.PP? || self.test.PT? || self.test.MAC?
      update_MT(sq, tests)
    elsif self.test.MT?
      update_MAD(sq, tests)
    elsif self.test.EX?
      update_CF(tests)
    end
  end

  private

  def update_MAC(sq, tests)
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

  def update_MT(sq, tests)
    mac = tests.MAC.find_by_school_quarter(sq).first.student_tests.where(student: self.student).first
    pp = tests.PP.find_by_school_quarter(sq).first.student_tests.where(student: self.student).first
    pt = tests.PT.find_by_school_quarter(sq).first.student_tests.where(student: self.student).first
    mt = tests.MT.find_by_school_quarter(sq).first.student_tests.where(student: self.student).first
    if mac.test.course.puniv?
      update_MT_PUNIV(mac, pp, pt, mt)
    else
      sqs = SchoolQuarter.all.order(quarter: :asc)
      if sq == sqs.first
        update_MT_PUNIV(mac, pp, pt, mt)
      else
        update_MT_Technical(mac: mac, pp: pp, pt: pt, mt: mt, sqs: sqs, sq: sq, tests: tests)
      end
    end
  end

  def update_MT_PUNIV(mac, pp, pt, mt)
    average = (pp.score + pt.score + mac.score) / 3
    mt.update(score: average)
  end

  def update_MT_Technical(p)
    past_sq = p[:sqs][p[:sqs].find_index(p[:sq]) - 1]
    past_mt = p[:tests].MT.find_by_school_quarter(past_sq).first.student_tests.where(student: self.student).first
    average = (past_mt.score + p[:mac].score + p[:pp].score + p[:pt].score) / 4
    p[:mt].update(score: average)
  end

  def update_MAD(sq, tests)
    mad = tests.MAD.first.student_tests.where(student: self.student).first
    if self.test.course.technical?
      update_MAD_Technical(sq, tests, mad)
    elsif self.test.course.puniv?
      update_MAD_PUNIV(sq, tests, mad)
    end
  end

  def update_MAD_Technical(sq, tests, mad)
    if sq.quarter == 3
      
      mt = tests.MT.find_by_school_quarter(sq).first.student_tests.where(student: self.student).first
      mad.update(score: mt.score)
    end
  end

  def update_MAD_PUNIV(sq, tests, mad)
    if sq.quarter == 3
      mts = tests.MT.map do |mt|
        mt.student_tests.where(student: self.student).first.score
      end
      average = mts.reduce(:+) / 3
      mad.update(score: average)
    end
  end

  def update_CF(tests)
    cf = tests.CF.first.student_tests.where(student: self.student).first
    mad = tests.MAD.first.student_tests.where(student: self.student).first
    ex = tests.EX.first.student_tests.where(student: self.student).first
    score = (mad.score * 0.4) + (ex.score * 0.6)
    cf.update(score: score)
  end
end
