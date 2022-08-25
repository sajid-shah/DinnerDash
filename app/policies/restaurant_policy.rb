# frozen_string_literal: true

RestaurantPolicy = Struct.new(:user, :record) do
  def create?
    user.admin? || user.superadmin?
  end

  def show?
    (user.present? && (user.admin? || user.superadmin?)) && (record.user_id == user.id)
  end

  def update?
    user.admin? || user.superadmin?
  end

  def new?
    user.admin? || user.superadmin?
  end

  def edit?
    user.admin? || user.superadmin?
  end

  def destroy?
    user.admin? || user.superadmin?
  end
end
