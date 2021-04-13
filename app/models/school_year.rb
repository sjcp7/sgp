class SchoolYear < ApplicationRecord
  scope :current, ->{ find_by(current: true) }

  def self.current=(school_year)
    current.each do |sy|
      sy.update(current: false)
    end
    school_year.update(current: true) and return
  end
end
