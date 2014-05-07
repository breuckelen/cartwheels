require File.expand_path('../../test_helper', __FILE__)
class MenuTest < ActiveSupport::TestCase
    fixtures :menus, :carts

    test "test that menu links to cart" do
        menu = Menu.new(cart_id: 5000)
        assert menu.invalid?

        menu.cart_id = carts(:coffee).id
        assert_equal false, menu.invalid?
    end
end
