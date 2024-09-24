class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!, :load_users, :load_ads

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Você não tem autorização para performar essa ação."
    redirect_to(request.referrer || root_path)
  end

  # SET USUARIOS EM TODOS OS CONTROLLERS QUE HERDAM DE APPLICATIONCONTROLLER
  def load_users
    @users = User.all.order(:user_name)
  end

  def load_ads
    @banner_ads = Ad.where(ad_type: 'Banner', active: true).order("RANDOM()").first
    @banner_sm_ads = Ad.where(ad_type: 'Banner-sm', active: true).order("RANDOM()").first
    @card_ads = Ad.where(ad_type: 'Card', active: true).order("RANDOM()").first
    @sidecard_ads = Ad.where(ad_type: 'Sidecard', active: true).order("RANDOM()").first
  end
end
