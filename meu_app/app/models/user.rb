class User < ApplicationRecord
  # ASSOCIAÇÕES
  belongs_to :role
  has_many :questionnaires
  has_many :attempts
  has_many :answers, through: :attempts

  # CONFIGURAÇÃO DO DEVISE
  # Módulos incluídos: :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # CALLBACKS
  # Define o papel padrão como 'student' para qualquer novo usuário criado
  before_validation :set_default_role, on: :create

  # MÉTODOS HELPER
  # Forma limpa de verificar o papel do usuário
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

  # LÓGICA DO CALLBACK
  def set_default_role
    # A menos que um papel já tenha sido definido, atribui o papel 'student'
    self.role ||= Role.find_by(title: 'student')
  end
end

