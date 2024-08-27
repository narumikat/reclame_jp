Complaint.destroy_all
Response.destroy_all
CompaniesUser.destroy_all
Company.destroy_all
User.destroy_all

puts 'Creating users...'

# USER ADMIN
User.create!(
  username: 'user_admin',
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

# USER SEM RECLAMACOES 
User.create!(
  username: 'user_no_complaints',
  email: 'usermail@mail.com',
  password: '123456',
  password_confirmation: '123456',
  first_name: 'User',
  last_name: 'No Complaints',
  phone_number: '1234567890',
  address: '123 Main St',
  city: 'New York',
  state: 'NY',
  zip_code: '10001',
  admin: false,
  is_company: false
)

# USER COM RECLAMACOES 

user_normal = User.create!(
  username: 'user_normal',
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
  username: 'user_normal2',
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

normal_users = [user_normal, user_normal2]

puts 'Normal users created!'
puts 'Creating company users...'

# COMPANY USERS 

user_company = User.create!(
  username: 'user_company1',
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
  username: 'user_company2',
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

puts 'Creating TEST companies...'

company1 = Company.create!(
  company_name: 'Company One',
  company_address: '123 Main St',
  company_city: 'New York',
  company_prefecture: Company::COMPANY_PREFECTURE.sample,
  company_zip_code: '10001',
  company_country: 'USA',
  company_phone_number: '1234567890',
  company_website: 'www.companyone.com',
  company_social_media: { facebook: 'www.facebook.com/companyone', twitter: 'www.twitter.com/companyone' },
  company_description: 'Company One is a company that does things.',
  company_contact_name: 'John Doe',
  company_contact_email: 'company@mail.com',
  company_category: Company::COMPANY_CATEGORY.sample
)

company2 = Company.create!(
  company_name: 'Company Two',
  company_address: '123 Main St',
  company_city: 'New York',
  company_prefecture: Company::COMPANY_PREFECTURE.sample,
  company_zip_code: '10001',
  company_country: 'USA',
  company_phone_number: '1234567890',
  company_website: 'www.companytwo.com',
  company_social_media: { facebook: 'www.facebook.com/companytwo', twitter: 'www.twitter.com/companytwo' },
  company_description: 'Company Two is a company that does things.',
  company_contact_name: 'John Doe',
  company_contact_email: 'company2@mail.com',
  company_category: Company::COMPANY_CATEGORY.sample
)

Company.create!(
  company_name: 'Company No Admin',
  company_address: '123 Main St',
  company_city: 'New York',
  company_prefecture: Company::COMPANY_PREFECTURE.sample,
  company_zip_code: '10001',
  company_country: 'USA',
  company_phone_number: '1234567890',
  company_website: 'www.companynoadmin.com',
  company_social_media: { facebook: 'www.facebook.com/companynoadmin', twitter: 'www.twitter.com/companynoadmin' },
  company_description: 'Company No Admin is a company that does things.',
  company_contact_name: 'John Doe',
  company_contact_email: 'company3@company.com',
  company_category: Company::COMPANY_CATEGORY.sample
)

companies = [company1, company2]

puts "Creating company EMPREITEIRAS..."

Company.create!(
  company_name: 'Kowa Corporation ',
  company_address: '123 Main St',
  company_city: 'New York',
  company_prefecture: Company::COMPANY_PREFECTURE.sample,
  company_zip_code: '10001',
  company_country: 'USA',
  company_phone_number: '1234567890',
  company_website: 'www.companynoadmin.com',
  company_social_media: { facebook: 'www.facebook.com/companynoadmin', twitter: 'www.twitter.com/companynoadmin' },
  company_description: 'Company No Admin is a company that does things.',
  company_contact_name: 'John Doe',
  company_contact_email: 'company3@company.com',
  company_category: Company::COMPANY_CATEGORY.sample
)

puts 'Create company associations'

role = CompaniesUser::ROLE

def associate_user_with_company(user, company, role)
  selected_role = role.sample
  CompaniesUser.create!(
    user: user,
    company: company,
    role: selected_role
  )
end

associate_user_with_company(user_company, company1, role)
associate_user_with_company(user_company, company2, role)
associate_user_with_company(user_company2, company2, role)



puts 'Users linked to companies with roles assigned!'

puts 'Creating complaints...'

complaints = [ 
  Complaint.create!(
    title: 'Produto Defeituoso',
    comment: 'Comprei um eletrônico dessa empresa e, após apenas duas semanas de uso, o dispositivo começou a apresentar problemas constantes de funcionamento. Entrei em contato com o suporte, mas a assistência foi insatisfatória e o problema não foi resolvido.',
    review: rand(1..5),
    company: companies.sample,
    user: normal_users.sample,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  ),
  Complaint.create!(
    title: 'Produto não entregue',
    comment: 'A empresa prometeu entregar meu pedido em 7 dias úteis, mas o produto só chegou após 3 semanas. Não houve comunicação clara sobre o atraso e, quando tentei buscar informações, a resposta foi demorada e pouco útil.',
    review: rand(1..5),
    company: companies.sample,
    user: normal_users.sample,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  ),
  Complaint.create!(
    title: 'Serviço ao Cliente Insatisfatório',
    comment: 'Experiência extremamente negativa com o atendimento ao cliente. Ao tentar resolver um problema com minha conta, fui tratado com desdém e a solução oferecida foi inadequada. A empresa não demonstrou preocupação com a minha situação.',
    review: rand(1..5),
    company: companies.sample,
    user: normal_users.sample,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  ),
  Complaint.create!(
    title: 'Cobrança Indevida',
    comment: 'Fui cobrado por um serviço que não contratei. Após revisar meu extrato, percebi que houve uma cobrança adicional que não foi autorizada. O processo de contestação foi burocrático e demorado, e o problema ainda não foi resolvido.',
    review: rand(1..5),
    company: companies.sample,
    user: normal_users.sample,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  ),
  Complaint.create!(
    title: 'Qualidade do Produto Abaixo do Esperado',
    comment: 'O produto recebido não corresponde às especificações apresentadas no site. A qualidade é inferior ao que foi descrito e a empresa não oferece um retorno eficiente para resolver o problema. Senti-me enganado com a discrepância entre a descrição e o item recebido.',
    review: rand(1..5),
    company: companies.sample,
    user: normal_users.sample,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  )
]

puts 'Complaints created!'

puts 'Creating responses...'

10.times do
  Response.create!(
    content: 'This is a response to a complaint.',
    complaint: complaints.sample,
    user: company_users.sample,
    company: companies.sample,
  )
end

puts 'Responses created!'
