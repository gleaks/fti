class ModulelogsController < ApplicationController
  before_action :set_modulelog, only: [:show, :edit, :update, :destroy]

  # GET /modulelogs
  def index
    @modulelogs = Modulelog.all.order(serial: :desc)
    @assemblies = Assembly.select(:name).distinct.order(name: :asc)
  end

  # GET /modulelogs/1
  def show
  end

  # GET /modulelogs/new
  def new
    @modulelog = Modulelog.new
    @categories = Category.where(table: 'modulelogs')
    @orders = Order.all
    @assemblies = Assembly.all
  end

  # GET /modulelogs/1/edit
  def edit
    @categories = Category.where(table: 'modulelogs')
    @orders = Order.all
    @assemblies = Assembly.all
  end

  # POST /modulelogs
  def create
    @modulelog = Modulelog.new(modulelog_params)

    if @modulelog.save
      redirect_to @modulelog, notice: 'Modulelog was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /modulelogs/1
  def update
    if @modulelog.update(modulelog_params)
      redirect_to @modulelog, notice: 'Modulelog was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /modulelogs/1
  def destroy
    @modulelog.destroy
    redirect_to modulelogs_url, notice: 'Modulelog was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modulelog
      @modulelog = Modulelog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def modulelog_params
      params.require(:modulelog).permit(:serial, :version, :order_id, :date, :category_id, :assembly_id, :notes)
    end
end
