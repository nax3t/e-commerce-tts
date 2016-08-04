class StoreFrontController < ApplicationController #declares class, and inhereits from Application Controller
  def all_items
  	@products = Product.all #assigns @products instance variable
  end

  def items_by_category
 		@category = Category.find(params[:cat_id]) #assigns @category to category specified by url parameter
 		@products = Product.all #assigns @products
 		@products_by_cat = [] #declares @products_by_cat as empty array (empties it if it wasn't empty, declares it as an array if it didn't exist yet)

 		@products.each do |product| #loops through @products
 			if product.category == @category #see next line
 				@products_by_cat.push(product) #adds product to @products_by_cat instance variable if it matches the specified @category
 			end #end of if statement
 		end #end of each loop
  end #end of items_by_category action/function/method

  def items_by_brand
  	@brand_name = params[:brand] #assigns @brand_name according to url element :brand
  	@products = Product.all #assigns @products
  	@products_by_brand = [] #declares @products_by_brand as empty array (empties it if it wasn't empty, declares it as an array if it didn't exist yet)

  	@products.each do |product| #iterates through @products
  		if product.brand == @brand_name #see next line
  			@products_by_brand.push(product) #adds product to @products_by_brand instance variable if it matches specified @brand_name
  		end #end of if statement
  	end #end of each loop
  end #end of def items_by_brand
end #end of class
