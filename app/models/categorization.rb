class Categorization < ApplicationRecord
  belongs_to :category, inverse_of: :categorizations
  belongs_to :item, inverse_of: :categorizations
end
