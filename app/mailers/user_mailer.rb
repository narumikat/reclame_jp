class UserMailer < ApplicationMailer
  def email_to_company(company_email, complaint)
    mail(
      to: company_email,
      from: ENV["USER_EMAIL"],
      subject: "Sua empresa recebeu uma reclamação: #{complaint.title}, veja os detalhes",
      body: 
    )
  end

end
