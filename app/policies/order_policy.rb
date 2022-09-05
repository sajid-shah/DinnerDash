# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  # NOTE: Be explicit about which records you allow access to!
  # def resolve
  #   scope.all
  # end
  def index?
    admin? || customer? || superadmin?
  end

  def show?
    customer? || admin? || superadmin?
  end

  def change_status?
    admin? || superadmin?
  end

  def destroy?
    nil? || customer?
  end
end
