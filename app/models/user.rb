# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  enum role: { superadmin: 0, admin: 1, customer: 2}
  after_initialize :set_default_role, if: :new_record?


  def set_default_role
    if User.first
      self.role ||= :customer
    else
      self.role ||= :superadmin
    end

  end

end
