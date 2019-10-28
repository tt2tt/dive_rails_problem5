class Task < ApplicationRecord

  validates :name, presence: true, length: {maximum: 50}
  validates :detail, presence: true, length: {maximum: 200}

  scope :latest, -> {order(created_at: :desc)}
end
