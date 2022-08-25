# frozen_string_literal: true

class OrderItemPolicy < ApplicationPolicy
  # NOTE: Be explicit about which records you allow access to!
  # def resolve
  #   scope.all
  # end
  def create?
    nil? || customer?
  end

  def update?
    nil? || customer?
  end

  def destroy?
    nil? || customer?
  end
end
