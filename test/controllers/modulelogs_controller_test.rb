require 'test_helper'

class ModulelogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @modulelog = modulelogs(:one)
  end

  test "should get index" do
    get modulelogs_url
    assert_response :success
  end

  test "should get new" do
    get new_modulelog_url
    assert_response :success
  end

  test "should create modulelog" do
    assert_difference('Modulelog.count') do
      post modulelogs_url, params: { modulelog: { assembly_id: @modulelog.assembly_id, category_id: @modulelog.category_id, date: @modulelog.date, notes: @modulelog.notes, order_id: @modulelog.order_id, serial: @modulelog.serial, version: @modulelog.version } }
    end

    assert_redirected_to modulelog_url(Modulelog.last)
  end

  test "should show modulelog" do
    get modulelog_url(@modulelog)
    assert_response :success
  end

  test "should get edit" do
    get edit_modulelog_url(@modulelog)
    assert_response :success
  end

  test "should update modulelog" do
    patch modulelog_url(@modulelog), params: { modulelog: { assembly_id: @modulelog.assembly_id, category_id: @modulelog.category_id, date: @modulelog.date, notes: @modulelog.notes, order_id: @modulelog.order_id, serial: @modulelog.serial, version: @modulelog.version } }
    assert_redirected_to modulelog_url(@modulelog)
  end

  test "should destroy modulelog" do
    assert_difference('Modulelog.count', -1) do
      delete modulelog_url(@modulelog)
    end

    assert_redirected_to modulelogs_url
  end
end
