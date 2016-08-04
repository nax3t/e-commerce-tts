class Category < ApplicationRecord
    #Sets up relationship to products, foreign ids should be stored in product
	has_many :products
end
