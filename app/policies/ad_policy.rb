class AdPolicy < ApplicationPolicy
  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def index?
    true
  end

  def edit?
    user.admin? || user == record.user
  end

  def update?
    user.admin? || user == record.user
  end

  def show?
    true
  end

  # def load_banner?
  #   true
  # end

  # def load_sm_banner?
  #   true
  # end

  # def load_card?
  #   true
  # end

  # def load_sidecard
  #   true
  # end

  def destroy?
    user.admin? || user == record.user
  end
end