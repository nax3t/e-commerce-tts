class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception #not entirely clear on what this does other than that what we have put in here so for is supposed to go after this statement. Looks like it is a security measure.

  before_action :categories, :brands #Callback to the categories and brands actions listed in this class, which is in turn inherited by all the other controllers. So these two functions are called before every other action (?)

  def categories
  	@categories = Category.all #assigns @categories as an array of all Categories
  end

  def brands
  	@brands = Product.pluck(:brand).sort.uniq! #assigns @brands as an array of all of the Product.brand elements, sorted and with duplicates removed
  	if @brands.nil? #in case @brands was assigned as nil due to .uniq! not encountering any duplicated :brands
  		@brands = Product.pluck(:brand).sort #assigns @brands as an array of all of the Product.brand elements, sorted.
  	end
  end
end
