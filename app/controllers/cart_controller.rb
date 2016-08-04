class CartController < ApplicationController
	before_filter :authenticate_user!, only: [:checkout] #runs the authenticate_user! function before the checkout action

  def add_to_cart
  	line_item = LineItem.new #assigns local variable line_item as a new instance of LineItem
  	line_item.product_id = params[:product_id] #assigns product_id according to the url :product_id param
  	line_item.quantity = params[:quantity] #assigns quantity according to the url :quantity param
  	line_item.save #saves the partially constructed LineItem to the database

  	line_item.line_item_total = line_item.product.price * line_item.quantity #the saved line_item references its own variables to assign its line_item_total variable
  	line_item.save #saves the updated line_item

  	redirect_to view_order_path #runs the view_order action
  end

  def view_order
  	@line_items = LineItem.all #assigns @line_items instance variable to hold all current LineItems
  end

  def checkout
  	@line_items = LineItem.all #assigns @line_items instance variable to hold all current LineItems
  	@order = Order.new #assigns @order as a new instance of Order
  	@order.user = current_user #assigns @order user varialbe as the current_user

  	sum = 0 #initializes the sum variable used below

  	@line_items.each do |line_item| #loops through each line item
  		if @order.order_items[line_item.product_id].nil? #if this hash key does not exist yet
	  		@order.order_items[line_item.product_id] = line_item.quantity #creates the order_items hash key and assigns the value based on the .quantity of the current line_item
	  	else #if the hash key does exist already
	  		@order.order_items[line_item.product_id] += line_item.quantity #increase the value associated with key based on the .quantity of the current line_item
	  	end #end of if statement

  		sum += line_item.line_item_total #increments the sum based on the current line_item_total
  	end #end of the each loop

  	@order.subtotal = sum #assigns the subtotal according to the sum
  	@order.sales_tax = sum * 0.08 #assigns the sales_tax
  	@order.grand_total = sum + @order.sales_tax #assigns the grand total by adding the sum and sales_tax
  	@order.save #saves the @order

  	@line_items.each do |line_item| #iterates through @line_items (in order to update the Product stock based on 'sold' goods)
  		line_item.product.quantity -= line_item.quantity #decrements the associated products quantity based on the line_item quantity (which was just 'sold')
  		line_item.product.save #saves the updated Product info
  	end #end of the each loop

  	LineItem.destroy_all #destroys all existing LineItems
  end
end
