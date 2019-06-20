require "application_system_test_case"

class ModulelogsTest < ApplicationSystemTestCase
  setup do
    @modulelog = modulelogs(:one)
  end

  test "visiting the index" do
    visit modulelogs_url
    assert_selector "h1", text: "Modulelogs"
  end

  test "creating a Modulelog" do
    visit modulelogs_url
    click_on "New Modulelog"

    fill_in "Assembly", with: @modulelog.assembly_id
    fill_in "Category", with: @modulelog.category_id
    fill_in "Date", with: @modulelog.date
    fill_in "Notes", with: @modulelog.notes
    fill_in "Order", with: @modulelog.order_id
    fill_in "Serial", with: @modulelog.serial
    fill_in "Version", with: @modulelog.version
    click_on "Create Modulelog"

    assert_text "Modulelog was successfully created"
    click_on "Back"
  end

  test "updating a Modulelog" do
    visit modulelogs_url
    click_on "Edit", match: :first

    fill_in "Assembly", with: @modulelog.assembly_id
    fill_in "Category", with: @modulelog.category_id
    fill_in "Date", with: @modulelog.date
    fill_in "Notes", with: @modulelog.notes
    fill_in "Order", with: @modulelog.order_id
    fill_in "Serial", with: @modulelog.serial
    fill_in "Version", with: @modulelog.version
    click_on "Update Modulelog"

    assert_text "Modulelog was successfully updated"
    click_on "Back"
  end

  test "destroying a Modulelog" do
    visit modulelogs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Modulelog was successfully destroyed"
  end
end
