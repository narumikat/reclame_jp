class TwilioClient
  def initialize
    @client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
  end

  def send_message(to:, body:)
    @client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: to,
      body: body
    )
  end

  def send_whatsapp(to:, body:)
    @client.messages.create(
      from: "whatsapp:#{ENV['TWILIO_WHATSAPP_NUMBER']}",
      to: "whatsapp:#{to}",
      body: body
    )
  end
end