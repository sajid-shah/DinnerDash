# frozen_string_literal: true

class Item < ApplicationRecord
  after_initialize :set_default_active, if: :new_record?
  def set_default_active
    self.active = true
  end
end
