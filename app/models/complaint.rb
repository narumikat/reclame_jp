class Complaint < ApplicationRecord
  include Pundit::Authorization
  belongs_to :user
  belongs_to :company
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
  enum status: { pending: 0, answered: 1 }
  validates :complaint_category, inclusion: { in: COMPLAINT_CATEGORY }, presence: true

  accepts_nested_attributes_for :company
  acts_as_favoritor

  def self.search(search)
    if search
      where('title LIKE ? OR comment LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  def update_status
    if responses.any?
      answered!
    else
      pending!
    end
  end

  def favorite(user)
    unless favorited_by?(user)
    user.favorite(self)
    update_column(:likes_count, likes_count + 1)
    end
  end

  def unfavorite(user)
    if favorited_by?(user)
      user.unfavorite(self)
      update_column(:likes_count, likes_count - 1)
    end
  end

  def favorited_by?(user)
    Favorite.exists?(favoritor: user, favoritable: self)
  end
end