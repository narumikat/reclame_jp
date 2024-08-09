class ResponsesController < ApplicationController
  before_action :set_complaint
  before_action :check_user_permission, only: [:create]
  
  def create
    @response = @complaint.responses.new(response_params)
    @response.user = current_user
    @response.company = @complaint.company
  
    if @response.save
      redirect_to [ @complaint.company, @complaint ], notice: 'Response was successfully created.'
    else
      Rails.logger.debug(@response.errors.full_messages.to_sentence)
      flash[:alert] = 'Failed to save the response: ' + @response.errors.full_messages.to_sentence
      render 'complaints/show'
    end
  end
  
  private

  def response_params
    params.require(:response).permit(:content)
  end

  def set_complaint
    @complaint = Complaint.find(params[:complaint_id])
  end

  def check_user_permission
    unless current_user.companies.include?(@complaint.company) || current_user.complaints.include?(@complaint)
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end
end
