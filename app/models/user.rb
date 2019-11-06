class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  before_update :protection_admin
  before_destroy :protection_admin

  has_secure_password
  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  before_validation { email.downcase! }

  scope :sort_by_id, -> {order(id: :asc)}

  private

  def  protection_admin
    admin_user = User.where(admin: true)
    if admin_user.length == 1  && self.admin == true
      throw :abort
    end
  end
end
