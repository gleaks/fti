include ActionView::Helpers::DateHelper
include ActionView::Helpers::JavaScriptHelper
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
        if params['comments'].present?
          comment = @modulelog.comments.create
          comment.comment = params['comments']['comment']
          comment.user_id = params['comments']['user_id']
          count = params['comments']['comment_count']
          if comment.save
            if count != nil
              if count == '1'
                format.js {render js: "$('#notedetail-#{location}').html('(<a data-toggle=\"collapse\" href=\"#note-expand-#{location}\" class=\"note-expand\">Show all notes...</a>)');
                                      $('#note1-#{location}').after('<div class=\"collapse\" id=\"note-expand-#{location}\"><div class=\"row\"><div class=\"col-sm-9\"><span class=\"badge badge-pill badge-#{@modulelog.comments.first.user.color}\">@#{@modulelog.comments.first.user.username}</span> #{@modulelog.comments.first.comment}</div><div class=\"col-sm-3\"><small class=\"float-right\">#{time_ago_in_words(@modulelog.comments.first.updated_at)} ago</small></div></div>');
                                      $('#note1-#{location}').html('<div class=\"col-sm-9\"><span class=\"badge badge-pill badge-#{comment.user.color}\">@#{comment.user.username}</span> #{escape_javascript(comment.comment)}</div><div class=\"col-sm-3\"><small class=\"float-right\">#{time_ago_in_words(comment.updated_at)} ago</small></div>');
                                      $('#nmodal-#{location}').modal('hide');
                                      $('#nform-#{location}').find('#comments_comment').val('');
                                      $('#nform-#{location}').find('#comments_user_id').after('<input value=\"2\" type=\"hidden\" name=\"comments[comment_count]\" id=\"comments_comment_count\">');"}
              else
                format.js {render js: "$('#note-expand-#{location}').prepend('<div class=\"row\"><div class=\"col-sm-9\"><span class=\"badge badge-pill badge-#{@modulelog.comments.first.user.color}\">@#{@modulelog.comments.first.user.username}</span> #{@modulelog.comments.first.comment}</div><div class=\"col-sm-3\"><small class=\"float-right\">#{time_ago_in_words(@modulelog.comments.first.updated_at)} ago</small></div></div>');
                                      $('#note1-#{location}').html('<div class=\"col-sm-9\"><span class=\"badge badge-pill badge-#{comment.user.color}\">@#{comment.user.username}</span> #{escape_javascript(comment.comment)}</div><div class=\"col-sm-3\"><small class=\"float-right\">#{time_ago_in_words(comment.updated_at)} ago</small></div>');
                                      $('#nmodal-#{location}').modal('hide');
                                      $('#nform-#{location}').find('#comments_comment').val('');
                                      $('#nform-#{location}').find('#comments_user_id').after('<input value=\"#{count.to_i + 1}\" type=\"hidden\" name=\"comments[comment_count]\" id=\"comments_comment_count\">');"}
              end
            else
              format.js {render js: "$('#notedetail-#{location}').text('');
                                    $('#notehead-#{location}').after('<div class=\"row\" id=\"note1-#{location}\"><div class=\"col-sm-9\"><span class=\"badge badge-pill badge-#{comment.user.color}\">@#{comment.user.username}</span> #{escape_javascript(comment.comment)}</div><div class=\"col-sm-3\"><small class=\"float-right\">#{time_ago_in_words(comment.updated_at)} ago</small></div></div>');
                                    $('#nmodal-#{location}').modal('hide');
                                    $('#nform-#{location}').find('#comments_comment').val('');
                                    $('#nform-#{location}').find('#comments_user_id').after('<input value=\"1\" type=\"hidden\" name=\"comments[comment_count]\" id=\"comments_comment_count\">');"}
            end
          else
            format.js {render js: "console.log('#{comment.errors.inspect}');"}
          end
        elsif params['modulelog']['progress'].nil?
          format.js {render js: "$('#update-#{location}').text('Updated: #{time_ago_in_words(@modulelog.updated_at)} ago by #{@modulelog.user.username}');
                                $('#progress-#{location}').html('<div class=\"mb-3 progress\"><div class=\"progress-bar\" role=\"progressbar\" style=\"width: #{@modulelog.progress.to_s}%\" aria-valuemin=\"0\" aria-valuemax=\"100\" aria-valuenow=\"#{@modulelog.progress.to_s}\">#{@modulelog.progress.to_s}%</div></div>');
                                $('#detail-#{location}').html('Currently assigned to #{@modulelog.assembly.shortname} <strong><a href=\"/modulelogs/#{@modulelog.id}\">#{@modulelog.serial}</a></strong> <span class=\"badge #{@modulelog.category.color}\">#{@modulelog.category.name}</span>');
                                if ($('#aform-#{location} > #modulelog_old_module').length) {
                                  $('#aform-#{location} > #modulelog_old_module').val('#{@modulelog.id}');
                                } else {
                                  $('#aform-#{location} > #modulelog_order_id').after('<input value=\"#{@modulelog.id}\" type=\"hidden\" name=\"modulelog[old_module]\" id=\"modulelog_old_module\">');
                                };
                                $('#pform-#{location} > #modulelog_id').val('#{@modulelog.id}');
                                $('#pform-#{location} .js-range-slider').data('ionRangeSlider').update({from: #{@modulelog.progress}});
                                $('#pform-#{location} > #modulelog_progress').val('#{@modulelog.progress}');
                                $('#pbutton-#{location}').prop('disabled', false);"}
        else
          format.js {render js: "$('#update-#{location}').text('Updated: #{time_ago_in_words(@modulelog.updated_at)} ago by #{@modulelog.user.username}');
                                $('#progress-#{location}').html('<div class=\"mb-3 progress\"><div class=\"progress-bar\" role=\"progressbar\" style=\"width: #{@modulelog.progress.to_s}%\" aria-valuemin=\"0\" aria-valuemax=\"100\" aria-valuenow=\"#{@modulelog.progress.to_s}\">#{@modulelog.progress.to_s}%</div></div>');"}
        end
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
      params.require(:modulelog).permit(:serial, :version, :order_id, :date, :category_id, :assembly_id, :notes, :location, :progress, :user_id, comments_attributes: [:title, :comment, :user_id, :_destroy])
    end
end
