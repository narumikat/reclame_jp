class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!, :load_users, :set_permissions_policy
  before_action :set_csp_headers

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

  def set_permissions_policy
    response.headers['Permissions-Policy'] = 'geolocation=(self "https://www.reclamejp.com"), microphone=(), camera=()'
  end

  def set_csp_headers
    nonce = SecureRandom.base64(16)
    response.headers['Content-Security-Policy'] = "script-src 'self' https: 'nonce-#{nonce}'"
    @nonce = nonce
  end
end
