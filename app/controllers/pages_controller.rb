class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about, :contact, :privacy, :terms, :faq]

  def home
    # @companies = Company.includes(company_logo_attachment: :blob).order(created_at: :desc).limit(5)
    @companies = Company.includes(:company_logo_attachment, :company_banner_attachment).order(created_at: :desc).limit(5)
    @complaints = Complaint.select(:id, :title, :company_id, :status, :complaint_category, :created_at).order(created_at: :desc).limit(5)
    @top_ranked_companies = Company
                              .joins(:complaints)
                              .left_joins(:complaints => :responses)
                              .group('companies.id')
                              .select('companies.*, COUNT(complaints.id) AS complaints_count,
             SUM(CASE WHEN responses.id IS NOT NULL THEN 1 ELSE 0 END) AS answered_complaints_count')
                              .having('COUNT(complaints.id) > 0 AND SUM(CASE WHEN responses.id IS NOT NULL THEN 1 ELSE 0 END) > 0')
                              .order(Arel.sql('SUM(CASE WHEN responses.id IS NOT NULL THEN 1 ELSE 0 END) / COUNT(complaints.id) DESC')).limit(3)
    @low_ranked_companies = Company
                              .joins(:complaints)
                              .left_joins(:complaints => :responses)
                              .group('companies.id')
                              .select('companies.*,
             COUNT(complaints.id) AS total_complaints,
             SUM(CASE WHEN responses.id IS NULL THEN 1 ELSE 0 END) AS unanswered_complaints,
             AVG(CASE WHEN responses.id IS NULL THEN 1 ELSE 0 END) AS unanswered_complaints_ratio')
                              .having('COUNT(complaints.id) > 0 AND SUM(CASE WHEN responses.id IS NULL THEN 1 ELSE 0 END) > 0')
                              .order('unanswered_complaints_ratio DESC').limit(3)
  end

  # Static pages
  def about
    # teste de template do email na page about
    # @complaint = Complaint.last
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
