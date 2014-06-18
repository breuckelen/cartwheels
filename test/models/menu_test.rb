require File.expand_path('../../test_helper', __FILE__)

class MenuTest < ActiveSupport::TestCase
    fixtures :menus

    test "cart should be present" do
        menu = menus(:halalMenu)
        presence_test(menu, :cart)
    end
end
