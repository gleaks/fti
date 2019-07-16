class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @categories = Category.where(table: 'orders')
    @productcategories = Category.where(table: 'products')
    @customers = Customer.all
    @products = Product.all
  end

  # GET /orders/1/edit
  def edit
    @customers = Customer.all
    @categories = Category.where(table: 'orders')
    @productcategories = Category.where(table: 'products').order(name: :asc)
    @products = Product.all.order(name: :asc)
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:name, :date, :delivery, :payment, :warranty, :category_id, :customer_id, order_boms_attributes: [:id, :product_id, :count, :_destroy])
    end
end
