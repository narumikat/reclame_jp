class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable
        #  :confirmable usar depois para ocnfirmar o email do user
has_one :company
after_create :allow_company_creation, if: :company?

def company?
  self.is_company
end

private

  def allow_company_creation
    # Lógica para permitir a criação de uma empresa
    # Por exemplo, criar um perfil de empresa associado a este usuário
    Company.create(user_id: self.id) # Exemplo de ação
  end
end
