class StoreFrontController < ApplicationController
  def all_items
  	@products = Product.all
  end

  def items_by_category
 		@category = Category.find(params[:id])
 		@products = Product.all
 		@products_by_cat = []

 		@products.each do |product|
 			if product.category == @category
 				@products_by_cat.push(product)
 			end 
 		end
  end

  def items_by_brand
  	@brand_name = params[:brand]
  	@products = Product.all
  	@products_by_brand = []

  	@products.each do |product|
  		if product.brand == @brand_name
  			@products_by_brand.push(product)
  		end
  	end
  end
end
