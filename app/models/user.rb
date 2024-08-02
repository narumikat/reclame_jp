class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable
        #  :confirmable usar depois para ocnfirmar o email do user
has_and_belongs_to_many :companies

  def company?
    self.is_company
  end
end
