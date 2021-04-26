class SchoolYear < ApplicationRecord
  scope :current, ->{ where(current: true) }
  before_update :update_current

  private

  def update_current
    current_sy = SchoolYear.current.first
    unless current_sy.nil?
      current_sy.update(current: false) unless current_sy == self
    end
  end
end
