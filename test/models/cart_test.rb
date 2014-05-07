require File.expand_path('../../helpers/cart_test_helper', __FILE__)

class CartTest < ActiveSupport::TestCase
    fixtures :carts

    test "name, city, borough, owner_secret, permit_number, zip_code, lat, lon \
    may not be nil for a cart" do
        cart = carts(:halal)
        cart_presence_test(cart)

        cart.owner_secret = nil

        assert cart.invalid?
        assert_equal "can't be blank", cart.errors[:owner_secret][0]
    end

    test "owner_secret, permit_number, zip_code, lat, and lon must all be  \
    numbers" do
        cart = carts(:halal)
        cart_numericality_test(cart)

        cart.owner_secret = "bob"

        cart.invalid?
        assert_equal "is not a number", cart.errors[:owner_secret][0]
    end

    test "zip_code must be a number, and exactly 5 digits long" do
        cart = carts(:halal)
        zip_code_test(cart)
    end
end
