class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }

  scope :sort_by_id, -> {order(id: :asc)}

  has_secure_password

  before_validation { email.downcase! }
end
