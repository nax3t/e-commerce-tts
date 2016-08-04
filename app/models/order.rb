class Order < ApplicationRecord
    #sets up relationships with line_items and user
	has_many :line_items
  belongs_to :user

    #Not 100% sure what this does. lets you use a hash in the database???
  serialize :order_items, Hash
end
