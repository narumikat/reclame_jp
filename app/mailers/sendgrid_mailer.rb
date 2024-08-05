class SendgridMailer < ActionMailer::Base
  def send_email
    @user = User.last

    mail = SendGrid::Mail.new
    mail.from = SendGrid::Email.new(email: ENV['SENDGRID_EMAIL'])
    dynamic_data = SendGrid::Personalization.new
    emails = [
      ENV['TEST_EMAIL']
    ]
    emails.each do |email|
      dynamic_data.add_to(SendGrid::Email.new(email: email))
    end
    dynamic_data.add_bcc(SendGrid::Email.new(email: ENV['BCC_EMAIL']))

    # Pass dynamic data with the correct placeholders
    dynamic_data.add_dynamic_template_data({
                                             "user_name" => @user.email,
                                           })
    mail.add_personalization(dynamic_data)
    mail.template_id = ENV['SENDGRID_TEMPLATE_ID']

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)

    if response.status_code.to_i == 202
      # Successful email delivery
      'Email sent successfully.'
    else
      # Handle error response
      'Failed to send email.'
      # Rails.logger.error("SendGrid error: #{response.body}")
    end
  end
end