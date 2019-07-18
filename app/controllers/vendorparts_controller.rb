class VendorpartsController < ApplicationController
  before_action :set_vendorpart, only: [:show, :edit, :update, :destroy]

  # GET /vendorparts
  def index
    @vendorparts = Vendorpart.all
  end

  # GET /vendorparts/1
  def show
  end

  # GET /vendorparts/new
  def new
    @vendorpart = Vendorpart.new
  end

  # GET /vendorparts/1/edit
  def edit
  end

  # POST /vendorparts
  def create
    @vendorpart = Vendorpart.new(vendorpart_params)

    if @vendorpart.save
      redirect_to @vendorpart, notice: 'Vendorpart was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /vendorparts/1
  def update
    if @vendorpart.update(vendorpart_params)
      redirect_to @vendorpart, notice: 'Vendorpart was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /vendorparts/1
  def destroy
    @vendorpart.destroy
    redirect_to vendorparts_url, notice: 'Vendorpart was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendorpart
      @vendorpart = Vendorpart.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vendorpart_params
      params.require(:vendorpart).permit(:vendor_id, :part_id, :vendor_part, :price, :quantity)
    end
end
