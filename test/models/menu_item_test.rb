require File.expand_path('../../test_helper', __FILE__)
class MenuItemTest < ActiveSupport::TestCase
    fixtures :menu_items

    test "description and price may not be nil for a user" do
        item = menu_items(:falafel)
        presence_test(item, :description)
        presence_test(item, :price)
    end

    test "price must be a valid number" do
        item = menu_items(:falafel)
        numericality_test(item, :price)
    end

    test "image_url must have a valid extension" do
        item = menu_items(:falafel)
        image_valid_test(item)
    end
end
