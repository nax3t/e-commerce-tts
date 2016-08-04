class LineItem < ApplicationRecord
  #Sets up relationships with products and orders (belongs_to signifies that this class should store the foreign ids)
  belongs_to :product
  belongs_to :order
end
