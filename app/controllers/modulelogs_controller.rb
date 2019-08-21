include ActionView::Helpers::DateHelper
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
        unless params['modulelog']['old_module'].nil?
          om_id = params['modulelog']['old_module']
          old_module = Modulelog.find(om_id)
          old_module.update_columns(:location => '', :order_id => '')
        end
        format.html { redirect_to @modulelog, notice: 'Modulelog was successfully updated.' }
        format.js {render js: "$('#update-#{location}').text('Updated: #{time_ago_in_words(@modulelog.updated_at)} ago by #{@modulelog.user.username}');
                              $('#progress-#{location}').html('<div class=\"mb-3 progress\"><div class=\"progress-bar\" role=\"progressbar\" style=\"width: #{@modulelog.progress.to_s}%\" aria-valuemin=\"0\" aria-valuemax=\"100\" aria-valuenow=\"#{@modulelog.progress.to_s}\">#{@modulelog.progress.to_s}%</div></div>');
                              $('#detail-#{location}').html('Currently assigned to #{@modulelog.assembly.shortname} <strong><a href=\"/modulelogs/#{@modulelog.id}\">#{@modulelog.serial}</a></strong> <span class=\"badge #{@modulelog.category.color}\">#{@modulelog.category.name}</span>');
                              if ($('#form-#{location} > #modulelog_old_module').length) {
                                $('#form-#{location} > #modulelog_old_module').val('#{@modulelog.id}');
                              } else {
                                $('#form-#{location} > #modulelog_order_id').after('<input value=\"#{@modulelog.id}\" type=\"hidden\" name=\"modulelog[old_module]\" id=\"modulelog_old_module\">');
                              };"}
      else
        format.html { render :edit }
        format.js { render js: "console.log('#{Rails.logger.info(@modulelog.errors.messages.inspect)}');" }
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
      params.require(:modulelog).permit(:serial, :version, :order_id, :date, :category_id, :assembly_id, :notes, :location, :progress, :user_id)
    end
end
