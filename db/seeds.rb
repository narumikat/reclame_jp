Complaint.destroy_all
Response.destroy_all
CompaniesUser.destroy_all
Company.destroy_all
User.destroy_all

puts 'Creating users...'

# USER ADMIN
User.create!(
  email: 'admin@mail.com',
  password: '123456',
  password_confirmation: '123456',
  first_name: 'Admin',
  last_name: 'One',
  phone_number: '1234567890',
  address: '123 Main St',
  city: 'New York',
  state: 'NY',
  zip_code: '10001',
  admin: true,
)

puts 'Admin user created!'
puts 'Creating normal users...'

user_normal = User.create!(
  email: 'user1@mail.com',
  password: '123456',
  password_confirmation: '123456',
  first_name: 'User',
  last_name: 'One',
  phone_number: '1234567890',
  address: '123 Main St',
  city: 'New York',
  state: 'NY',
  zip_code: '10001',
  admin: false,
  is_company: false
)

user_normal2 = User.create!(
  email: 'user2@mail.com',
  password: '123456',
  password_confirmation: '123456',
  first_name: 'User',
  last_name: 'Two',
  phone_number: '1234567890',
  address: '123 Main St',
  city: 'New York',
  state: 'NY',
  zip_code: '10001',
  admin: false,
  is_company: false
)

company_users = [user_normal, user_normal2]

puts 'Normal users created!'
puts 'Creating company users...'

# COMPANY USERS 

user_company = User.create!(
  email: 'user_company1@mail.com',
  password: '123456',
  password_confirmation: '123456',
  first_name: 'User1',
  last_name: 'Company1',
  phone_number: '1234567890',
  address: '123 Main St',
  city: 'New York',
  state: 'NY',
  zip_code: '10001',
  admin: false,
  is_company: true,
)

user_company2 = User.create!(
  email: 'user_company2@mail.com',
  password: '123456',
  password_confirmation: '123456',
  first_name: 'User2',
  last_name: 'Company2',
  phone_number: '1234567890',
  address: '123 Main St',
  city: 'New York',
  state: 'NY',
  zip_code: '10001',
  admin: false,
  is_company: true,
)

company_users = [user_company, user_company2]

puts 'Users created!'

puts 'Creating companies...'

company1 = Company.create!(
  company_name: 'Company One',
  company_address: '123 Main St',
  company_city: 'New York',
  company_state: 'NY',
  company_zip_code: '10001',
  company_country: 'USA',
  company_phone_number: '1234567890',
  company_website: 'www.companyone.com',
  company_social_media: { facebook: 'www.facebook.com/companyone', twitter: 'www.twitter.com/companyone' },
  company_description: 'Company One is a company that does things.',
  company_contact_name: 'John Doe',
  company_contact_email: 'company@mail.com'
)

company2 = Company.create!(
  company_name: 'Company Two',
  company_address: '123 Main St',
  company_city: 'New York',
  company_state: 'NY',
  company_zip_code: '10001',
  company_country: 'USA',
  company_phone_number: '1234567890',
  company_website: 'www.companytwo.com',
  company_social_media: { facebook: 'www.facebook.com/companytwo', twitter: 'www.twitter.com/companytwo' },
  company_description: 'Company Two is a company that does things.',
  company_contact_name: 'John Doe',
  company_contact_email: 'company2@mail.com'
)

companies = [company1, company2]

# Create company associations
company1.users << user_company unless company1.users.include?(user_company)
company2.users << user_company unless company2.users.include?(user_company)
company2.users << user_company2 unless company2.users.include?(user_company2)

puts 'Companies created!'

puts 'Creating complaints...'

complaints = [ 
  Complaint.create!(
    title: 'Produto Defeituoso',
    comment: 'Comprei um eletrônico dessa empresa e, após apenas duas semanas de uso, o dispositivo começou a apresentar problemas constantes de funcionamento. Entrei em contato com o suporte, mas a assistência foi insatisfatória e o problema não foi resolvido.',
    review: rand(1..5),
    company: companies.sample,
    user: company_users.sample,
  ),
  Complaint.create!(
    title: 'Produto não entregue',
    comment: 'A empresa prometeu entregar meu pedido em 7 dias úteis, mas o produto só chegou após 3 semanas. Não houve comunicação clara sobre o atraso e, quando tentei buscar informações, a resposta foi demorada e pouco útil.',
    review: rand(1..5),
    company: companies.sample,
    user: company_users.sample,
  ),
  Complaint.create!(
    title: 'Serviço ao Cliente Insatisfatório',
    comment: 'Experiência extremamente negativa com o atendimento ao cliente. Ao tentar resolver um problema com minha conta, fui tratado com desdém e a solução oferecida foi inadequada. A empresa não demonstrou preocupação com a minha situação.',
    review: rand(1..5),
    company: companies.sample,
    user: company_users.sample,
  ),
  Complaint.create!(
    title: 'Cobrança Indevida',
    comment: 'Fui cobrado por um serviço que não contratei. Após revisar meu extrato, percebi que houve uma cobrança adicional que não foi autorizada. O processo de contestação foi burocrático e demorado, e o problema ainda não foi resolvido.',
    review: rand(1..5),
    company: companies.sample,
    user: company_users.sample,
  ),
  Complaint.create!(
    title: 'Qualidade do Produto Abaixo do Esperado',
    comment: 'O produto recebido não corresponde às especificações apresentadas no site. A qualidade é inferior ao que foi descrito e a empresa não oferece um retorno eficiente para resolver o problema. Senti-me enganado com a discrepância entre a descrição e o item recebido.',
    review: rand(1..5),
    company: companies.sample,
    user: company_users.sample,
  )
]

puts 'Complaints created!'

puts 'Creating responses...'

8.times do
  Response.create!(
    content: 'This is a response to a complaint.',
    complaint: complaints.sample,
    user: company_users.sample,
    company: companies.sample
  )
end

puts 'Responses created!'
