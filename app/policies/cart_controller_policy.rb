# frozen_string_literal: true

class CartControllerPolicy < ApplicationPolicy
  def index?
    nil? || customer?
  end

  def checkout?
    customer?
  end
end
