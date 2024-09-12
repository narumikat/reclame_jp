class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :about, :contact, :privacy, :terms, :faq ]

  def home
    @companies = Company.select(:id, :company_name, :created_at, :company_category, :company_banner_url, :company_logo_url).order(created_at: :desc).limit(5)
    @complaints = Complaint.select(:id, :title, :company_id, :status, :complaint_category, :created_at).order(created_at: :desc).limit(5)
    @top_ranked_companies = Company.top_company_ranking.limit(3)
    @low_ranked_companies = Company.low_company_ranking.limit(3)
  end

  # Static pages
  def about
    @complaint = Complaint.last
    
  end

  def contact

  end

  def privacy

  end

  def terms

  end

  def faq

  end

  # SMS and Whatsapp
  def sms
    phone_number = format_number(params[:phone])
    message = params[:message]
    TwilioClient.new.send_message(to: phone_number, body: message)
    redirect_to root_path, notice: "SMS enviado com sucesso!"
  end

  def whatsapp
    phone_number = format_number(params[:phone])
    message = params[:message]
    TwilioClient.new.send_whatsapp(to: phone_number, body: message)
    redirect_to root_path, notice: "Whatsapp enviado com sucesso!"
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
