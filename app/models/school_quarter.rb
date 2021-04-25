class SchoolQuarter < ApplicationRecord
  scope :current, ->{ where(current: true) }
  before_update :update_current

  private

  def update_current
    current_sq = SchoolQuarter.current.first
    current_sq.update(current: false) unless current_sq == self
  end
end
