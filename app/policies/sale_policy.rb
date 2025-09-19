class SalePolicy < ApplicationPolicy
  def show?
    user == record.user
  end

  def destroy?
    user == record.user
  end

  def index?
    true
  end
end
