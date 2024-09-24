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
    @banner_ads = Ad.where(ad_type: 'banner').order(created_at: :desc).to_a
    @random_banner = @banner_ads.sample
    @banner_sm_ads = Ad.where(ad_type: 'banner-sm').order(created_at: :desc).to_a
    @random_banner_sm = @banner_sm_ads.sample
    @card_ads = Ad.where(ad_type: 'card').order(created_at: :desc).to_a
    @random_card = @card_ads.sample
  end
  
end
