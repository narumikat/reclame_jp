class UserMailer < ApplicationMailer
  def email_to_company(company_email, complaint)
    @complaint = complaint
    mail(
      to: company_email,
      from: ENV["USER_EMAIL"],
      subject: "Sua empresa recebeu uma reclamação: #{complaint.title}, veja os detalhes",
      template_name: 'email_to_company',
      template_path: 'user_mailer'
    )
  end  

  def email_company_to_user(user_email, response)
    mail(
      to: user_email,
      from: ENV["USER_EMAIL"],
      subject: "Resposta da Empresa",
      body: "Resposta:\n
      #{response.content}"
    )
  end
end
