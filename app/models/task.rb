class Task < ApplicationRecord
  extend Enumerize

  validates :name, presence: true, length: {maximum: 50}
  validates :detail, presence: true, length: {maximum: 200}
  validates :deadline, presence: true

  scope :sort_by_crated_at, -> {order(created_at: :desc)}
  scope :sort_by_deadline, -> {order(deadline: :asc)}
  scope :sort_by_priority, -> {order(priority: :desc)}
  scope :search_by_both, -> (search){where(['name LIKE ?', "%#{search[:name]}%"]).where(status: "#{search[:status]}")}
  scope :search_by_name, -> (search){where(['name LIKE ?', "%#{search[:name]}%"])}
  scope :search_by_status, -> (search){where(status: "#{search[:status]}")}

  enumerize :status, in: { 未着手: 0, 着手中: 1, 完了: 2 }
  enumerize :priority, in: { 高: 2, 中: 1, 低: 0}

  def self.search(search)
    if search[:name].present? && search[:status].present?
     Task.search_by_both(search)
    elsif search[:name].present?
      Task.search_by_name(search)
    elsif search[:status].present?
      Task.search_by_status(search)
    else
      Task.sort_by_crated_at
    end
    end
end
