class ProductsController < ApplicationController #declares controller and inhereits from ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy] #callback to :set_product before specified actions

  # GET /products
  # GET /products.json
  def index
    @products = Product.all #assigns @products instance variable
  end

  # GET /products/1
  # GET /products/1.json
  def show #empty, but still allows navigation to show view
  end

  # GET /products/new
  def new
    @product = Product.new #assigns @product as a new Product that was just instantiated
    @categories = Category.all #assigns @categories
  end

  # GET /products/1/edit
  def edit
    @categories = Category.all #assigns @categories
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params) #assigns @product as new instance of Product with paramters determined by the return of the product_params function

    respond_to do |format| #not sure about respond_to, but do |format| looks like a loop
      if @product.save #if @product successfully saves. handy because the function gets processed like normal and then the result is fed to the if.
        format.html { redirect_to @product, notice: 'Product was successfully created.' } #not 100% sure. looks like to takes you to the product show page
        format.json { render :show, status: :created, location: @product } #same as above
      else
        format.html { render :new } #looks like it takes you to new product action
        format.json { render json: @product.errors, status: :unprocessable_entity } #not sure
      end #end of if
    end #end of loop(?)
  end #end of def create

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format| #same as above
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy #destroys the Product referenced by @product
    respond_to do |format| #still not sure
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' } #redirects to product page?
      format.json { head :no_content } #??
    end
  end

  private #code below here is private to this class
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id]) #Assigns @product as the Product that matches the :id in the url
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :description, :quantity, :brand, :rating, :category_id, :image) #used for populating a new Product. whitelists the allowable keys
    end
end
