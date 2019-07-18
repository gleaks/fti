class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /categories
  def index
    @categories = Category.all
  end

  # GET /categories/1
  def show
  end

  def modal
    @category = Category.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.js { render js: "$('#modal-window').modal('hide'); $('##{singular(@category.table)}_category_id').append('<option value=\"#{@category.id}\" selected=\"selected\">#{@category.name}</option>');" }
      else
        render :new
      end
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name, :table, :order, :visible, :color)
    end

    def singular(a)
      if a == 'assemblies'
        return 'assembly'
      else
        return a[0...-1]
      end
    end
end
