require 'test_helper'

class VendorpartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vendorpart = vendorparts(:one)
  end

  test "should get index" do
    get vendorparts_url
    assert_response :success
  end

  test "should get new" do
    get new_vendorpart_url
    assert_response :success
  end

  test "should create vendorpart" do
    assert_difference('Vendorpart.count') do
      post vendorparts_url, params: { vendorpart: { part_id: @vendorpart.part_id, price: @vendorpart.price, quantity: @vendorpart.quantity, vendor_id: @vendorpart.vendor_id, vendor_part: @vendorpart.vendor_part } }
    end

    assert_redirected_to vendorpart_url(Vendorpart.last)
  end

  test "should show vendorpart" do
    get vendorpart_url(@vendorpart)
    assert_response :success
  end

  test "should get edit" do
    get edit_vendorpart_url(@vendorpart)
    assert_response :success
  end

  test "should update vendorpart" do
    patch vendorpart_url(@vendorpart), params: { vendorpart: { part_id: @vendorpart.part_id, price: @vendorpart.price, quantity: @vendorpart.quantity, vendor_id: @vendorpart.vendor_id, vendor_part: @vendorpart.vendor_part } }
    assert_redirected_to vendorpart_url(@vendorpart)
  end

  test "should destroy vendorpart" do
    assert_difference('Vendorpart.count', -1) do
      delete vendorpart_url(@vendorpart)
    end

    assert_redirected_to vendorparts_url
  end
end
