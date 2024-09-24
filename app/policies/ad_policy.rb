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

  def show?
    true
  end
end