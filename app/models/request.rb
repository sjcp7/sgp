class Request < ApplicationRecord
  belongs_to :teacher
  belongs_to :test
  has_one :batch, through: :test
  has_one :batch_director, through: :test

  scope :find_by_batches, ->(batches) { joins(:batch).where(batch: { id: [batches]}) }
end
