class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy] #runs the set_category function before running the specified actions

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all #assigns @categories
  end

  # GET /categories/1
  # GET /categories/1.json
  def show #empty, but allows for navigation to show view
  end

  # GET /categories/new
  def new
    @category = Category.new #defines @cateory as a new, empty Category
  end

  # GET /categories/1/edit
  def edit #empty, but allows navigation to edit view
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params) #assigns @category as a new instance of Category, with params from the url (as handled by the category_params function)

    respond_to do |format| #not sure about respond_to. do |format| looks like a loop though
      if @category.save #if @category succesfully saves. 
        format.html { redirect_to @category, notice: 'Category was successfully created.' } #not sure
        format.json { render :show, status: :created, location: @category } #not sure
      else #if @category does not succesfully save
        format.html { render :new } #not sure
        format.json { render json: @category.errors, status: :unprocessable_entity } #not sure
      end #end of if
    end #end of loop(?)
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format| #same as above
      if @category.update(category_params) #if @category succesfully updates with the params from the url as handled by category_params
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy #destroys the Category referenced by @category
    respond_to do |format| #not sure. looks like a loop
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' } #redirects to categories view?
      format.json { head :no_content } #??
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id]) #assigns @catagory to the Category that has the same id as the :id param in the url
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)#requires and whitelists elements from the url. to be fed into other functions like .new and .update
    end
end
