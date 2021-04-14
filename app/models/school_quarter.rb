class SchoolQuarter < ApplicationRecord
  scope :current, ->{ find_by(current: true) }

  def self.current=(school_quarter)
    current.each do |sq|
      sq.update(current: false)
    end
    school_quarter.update(current: true) and return
  end
end
