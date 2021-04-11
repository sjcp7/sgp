class Teacher < ApplicationRecord
  has_one :user, as: :profile
  accept_nested_attributes_for :user
end
