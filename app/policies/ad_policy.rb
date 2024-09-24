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

  def load_banner_ads?
    true
  end

  def load_card_ads?
    true
  end

  def destroy?
    user.admin? || user == record.user
  end
end