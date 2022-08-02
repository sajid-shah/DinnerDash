# frozen_string_literal: true

class Item < ApplicationRecord
  enum active: { no: 0, yes: 1 }

  after_initialize :set_default_active, if: :new_record?

  def set_default_active
    self.active ||= :yes
  end
end
