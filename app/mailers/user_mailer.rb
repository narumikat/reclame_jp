class UserMailer < ApplicationMailer

  def email_to_company(user_email, complaint)
    mail(
      to: user_email,
      from: ENV["USER_EMAIL"],
      subject: "Reclamação de Usuário, #{complaint.title} por favor, responda esse email.",
      body: "Reclamação:\n
#{complaint.title}\n
#{complaint.comment}"
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
