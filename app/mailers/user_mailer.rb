class UserMailer < ApplicationMailer

  def email_to_user(user_email, complaint)
    mail(
      to: user_email,
      from: ENV["USER_EMAIL"],
      subject: 'Reclamação enviada com sucesso',
      body: "#{complaint.title} - #{complaint.comment}"
    )
  end

end
