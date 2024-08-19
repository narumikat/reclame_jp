class CompaniesUser < ApplicationRecord
  ROLE = [
  'Gerente',
  'Representante',
  'Tantousha',
  'Diretor',
  'Supervisor',
  'Coordenador',
  'Analista',
  'Consultor',
  'Assistente',
  'Estagiário',
  'Executivo',
  'Especialista',
  'Operador',
  'Administrador',
  'Engenheiro',
  'Desenvolvedor',
  'Designer',
  'Marketing',
  'Vendas',
  'Recursos Humanos'
]
  belongs_to :company
  belongs_to :user

  validates :role, presence: true, inclusion: { in: ROLE }

end
