class UserMailer < ApplicationMailer
  def email_to_company(company_email, complaint)
    mail(
      to: company_email,
      from: ENV["USER_EMAIL"],
      subject: "Sua empresa recebeu uma reclamação: #{complaint.title}, veja os detalhes",
      body: 
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
