class Item < ApplicationRecord
  enum active: %i[yes no]
  after_initialize :set_default_active, if: :new_record?
  def set_default_active
    self.active ||= :yes
  end
end
