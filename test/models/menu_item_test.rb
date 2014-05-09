require File.expand_path('../../test_helper', __FILE__)

class MenuItemTest < ActiveSupport::TestCase
    fixtures :menu_items

    test "description, price should be present" do
        item = menu_items(:falafel)
        presence_test(item, :description)
        presence_test(item, :price)
        presence_test(item, :menu)
    end

    test "price must be a number" do
        item = menu_items(:falafel)
        numericality_test(item, :price)
    end
end
