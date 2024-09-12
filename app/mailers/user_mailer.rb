class UserMailer < ApplicationMailer

  def email_to_user(user_email, complaint)
    mail(
      to: user_email,
      from: ENV["USER_EMAIL"],
      subject: 'Reclamação enviada com sucesso',
      body: "Reclamação:\n
#{complaint.title}\n
#{complaint.comment}"
    )
  end

end
