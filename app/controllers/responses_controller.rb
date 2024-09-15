class ResponsesController < ApplicationController
  before_action :set_complaint
  before_action :check_user_permission, only: [:create]
  
  def create
    authorize Response
    @response = @complaint.responses.new(response_params)
    @response.user = current_user
    @response.company = @complaint.company
  
    if @response.save
      UserMailer.email_company_to_user(@complaint, @response).deliver_now
      redirect_to [ @complaint.company, @complaint ], notice: 'Resposta criada com sucesso.'
    else
      Rails.logger.debug(@response.errors.full_messages.to_sentence)
      flash[:alert] = 'Failed to save the response: ' + @response.errors.full_messages.to_sentence
      render 'complaints/show'
    end
  end

  def like
    @response.favorite(current_user)
    # current_user.favorite(@response)
    respond_to do |format|
      format.html { redirect_to @response }
      format.json {
        render_like_button
      }
    end
    authorize @response
  end

  def unlike
    @response.unfavorite(current_user)

    respond_to do |format|
      format.html { redirect_to @response }
      format.json {
        render_like_button
      }
    end
    authorize @response
  end
  
  private

  def response_params
    params.require(:response).permit(:content, :likes_count, :parent_id)
  end

  def set_complaint
    @complaint = Complaint.find(params[:complaint_id])
  end

  def render_like_button
    render json: { like_button_html: render_to_string(partial: 'components/like_button', locals: { item: @response, 
                                                                                                    path1: unlike_company_complaint_response_path(@response.complaint_id, @response), 
                                                                                                    path2: like_company_complaint_response_path(@response.complaint_id, @response) }) }
  end

  def check_user_permission
    unless current_user.companies.include?(@complaint.company) || current_user.complaints.include?(@complaint)
      redirect_to root_path, alert: 'Você não tem permissão para responder a essa reclamação.'
    end
  end
end
