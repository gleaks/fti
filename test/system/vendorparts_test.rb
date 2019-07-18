require "application_system_test_case"

class VendorpartsTest < ApplicationSystemTestCase
  setup do
    @vendorpart = vendorparts(:one)
  end

  test "visiting the index" do
    visit vendorparts_url
    assert_selector "h1", text: "Vendorparts"
  end

  test "creating a Vendorpart" do
    visit vendorparts_url
    click_on "New Vendorpart"

    fill_in "Part", with: @vendorpart.part_id
    fill_in "Price", with: @vendorpart.price
    fill_in "Quantity", with: @vendorpart.quantity
    fill_in "Vendor", with: @vendorpart.vendor_id
    fill_in "Vendor part", with: @vendorpart.vendor_part
    click_on "Create Vendorpart"

    assert_text "Vendorpart was successfully created"
    click_on "Back"
  end

  test "updating a Vendorpart" do
    visit vendorparts_url
    click_on "Edit", match: :first

    fill_in "Part", with: @vendorpart.part_id
    fill_in "Price", with: @vendorpart.price
    fill_in "Quantity", with: @vendorpart.quantity
    fill_in "Vendor", with: @vendorpart.vendor_id
    fill_in "Vendor part", with: @vendorpart.vendor_part
    click_on "Update Vendorpart"

    assert_text "Vendorpart was successfully updated"
    click_on "Back"
  end

  test "destroying a Vendorpart" do
    visit vendorparts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vendorpart was successfully destroyed"
  end
end
