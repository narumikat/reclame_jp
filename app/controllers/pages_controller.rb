class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end
  def sms
    phone_number = format_number(params[:phone])
    message = params[:message]
    TwilioClient.new.send_message(to: phone_number, body: message)
    redirect_to root_path, notice: "SMS sent!"
  end

  def whatsapp
    phone_number = format_number(params[:phone])
    message = params[:message]
    TwilioClient.new.send_whatsapp(to: phone_number, body: message)
    redirect_to root_path, notice: "Whatsapp sent!"
  end

  private

  def format_number(number)
    number = number.gsub(/[^0-9]/, '')
    if number.start_with?('0')
      number = number[1..-1]
    end
    unless number.start_with?('81')
      number = "81#{number}"
    end
    number = "+#{number}" unless number.start_with?('+')
    number
  end
end
