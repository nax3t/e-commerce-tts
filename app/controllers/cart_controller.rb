class CartController < ApplicationController
	# checks if user is signed in otherwise they cannot checkout
  before_filter :authenticate_user!, only: [:checkout]

  # gives selected products and quantities ID's to be called later
  def add_to_cart
  	line_item = LineItem.new
  	line_item.product_id = params[:product_id]
  	line_item.quantity = params[:quantity]
  	line_item.save

  	line_item.line_item_total = line_item.product.price * line_item.quantity
  	line_item.save

  	redirect_to view_order_path
  end

  def view_order
  	@line_items = LineItem.all
  end

  # takes all items and adds the price starting from 0 and adds tax in
  def checkout
  	@line_items = LineItem.all
  	@order = Order.new
  	@order.user = current_user

  	sum = 0

    # for each line item add it's quantity if there are multiples
  	@line_items.each do |line_item|
  		if @order.order_items[line_item.product_id].nil?
	  		@order.order_items[line_item.product_id] = line_item.quantity
	  	else
	  		@order.order_items[line_item.product_id] += line_item.quantity
	  	end

  		sum += line_item.line_item_total
  	end

    # takes line item total and adds salestax
  	@order.subtotal = sum
  	@order.sales_tax = sum * 0.08
  	@order.grand_total = sum + @order.sales_tax
  	@order.save

  	@line_items.each do |line_item|
  		line_item.product.quantity -= line_item.quantity
  		line_item.product.save
  	end

    #destroys items after checkout process is done so cart returns to empty 
  	LineItem.destroy_all
  end
end
