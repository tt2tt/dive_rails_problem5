class Task < ApplicationRecord
  def self.latest
    order(created_at: :desc)
  end
end
