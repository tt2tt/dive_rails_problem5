class Task < ApplicationRecord

  validates :name, presence: true, length: {maximum: 50}
  validates :detail, presence: true, length: {maximum: 200}
  validates :deadline, presence: true

  scope :sort_by_crated_at, -> {order(created_at: :desc)}
  scope :sort_by_deadline, -> {order(deadline: :asc)}
end
