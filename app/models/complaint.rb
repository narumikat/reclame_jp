class Complaint < ApplicationRecord
  belongs_to :user
  belongs_to :company, optional: true 
  has_many :responses, dependent: :destroy

  COMPLAINT_CATEGORY = [
    'Financeira',
    'Produto com defeito',
    'Atendimento',
    'Cobrança indevida',
    'Propaganda enganosa',
    'Problemas com garantia',
    'Problemas com entrega',
    'Problemas com troca',
    'Problemas com devolução',
    "Aplicativo",
    'Website',
    'Redes sociais',
    'Telefone',
    'E-mail',
    'Chat',
    'Loja física',
    'Contrato',
    'Segurança',
    'Privacidade',
    'Diversidade e Inclusão',
    'Sustentabilidade',
    'Práticas Éticas de Negócios',
    'Outros'
]

  validates :title, presence: true
  validates :comment, presence: true
  validates :user_id, presence: true
  validates :complaint_category, presence: true, inclusion: { in: COMPLAINT_CATEGORY }

  accepts_nested_attributes_for :company

  def self.search(search)
    if search
      where('title LIKE ? OR comment LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end
end