# frozen_string_literal: true

class ItemPolicy < ApplicationPolicy
  # NOTE: Be explicit about which records you allow access to!
  # def resolve
  #   scope.all
  # end
  def create?
    superadmin? || admin?
  end

  def new?
    superadmin? || admin?
  end

  def update?
    superadmin? || admin?
  end

  def destroy?
    superadmin? || admin?
  end

  def show?
    superadmin? || admin?
  end

  def toggle_status?
    superadmin? || admin?
  end
end
