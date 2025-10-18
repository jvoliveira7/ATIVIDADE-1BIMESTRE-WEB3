class User < ApplicationRecord
  belongs_to :role
  has_many :questionnaires, dependent: :destroy
  has_many :attempts, dependent: :destroy
  has_many :answers, through: :attempts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_default_role, on: :create

  def admin?
    role&.title == 'admin'
  end

  def moderator?
    role&.title == 'moderator'
  end

  def student?
    role&.title == 'student'
  end

  private

  def set_default_role
    self.role ||= Role.find_by(title: 'student')
  end
end
