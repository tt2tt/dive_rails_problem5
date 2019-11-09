class Task < ApplicationRecord
  extend Enumerize
  enumerize :status, in: { 未着手: 0, 着手中: 1, 完了: 2 }
  enumerize :priority, in: { 高: 2, 中: 1, 低: 0}

  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  validates :name, presence: true, length: {maximum: 50}
  validates :detail, presence: true, length: {maximum: 200}
  validates :deadline, presence: true

  scope :sort_by_crated_at, -> {order(created_at: :desc)}
  scope :sort_by_deadline, -> {order(deadline: :asc)}
  scope :sort_by_priority, -> {order(priority: :desc)}
  scope :search_by_name, -> (search){where(['name LIKE ?', "%#{search[:name]}%"]) if search[:name].present?}
  scope :search_by_status, -> (search){where(status: "#{search[:status]}") if search[:status].present?}
  scope :search_by_labels, -> (task_ids){where(id: task_ids)}

  def self.search(search)
    task_ids = TaskLabel.where(label_id: search[:label_ids]).pluck(:task_id)
    if task_ids.present?
      Task.search_by_name(search).search_by_status(search).search_by_labels(task_ids)
    else
      Task.search_by_name(search).search_by_status(search)
    end
  end
  
end
