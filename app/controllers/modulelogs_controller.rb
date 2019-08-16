class ModulelogsController < ApplicationController
  before_action :set_modulelog, only: [:show, :edit, :update, :destroy]

  # GET /modulelogs
  def index
    @modulelogs = Modulelog.all.order(serial: :desc)
    @assemblies = Assembly.select(:shortname).distinct.select('shortname, name').order(shortname: :asc)
    @categories = Category.where(table: 'modulelogs')
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
    location = params['modulelog']['location']
    respond_to do |format|
      if @modulelog.update(modulelog_params)
        format.html { redirect_to @modulelog, notice: 'Modulelog was successfully updated.' }
        format.js {render js: "$('##{location}').text('Updated: just now');"}
      else
        format.html { render :edit }
        format.js { puts "ERROR!!" }
      end
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
