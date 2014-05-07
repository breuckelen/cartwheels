require File.expand_path('../../helpers/cart_test_helper', __FILE__)

class CartSuggestionTest < ActiveSupport::TestCase
    fixtures :cart_suggestions

    test "name, city, borough, permit_number, zip_code, lat, lon \
    may not be nil for a cart" do
        cart = cart_suggestions(:korean)
        cart_presence_test(cart)
        presence_test(cart, :approved)
    end

    test "permit_number, zip_code, lat, and lon must all be numbers" do
        cart = cart_suggestions(:korean)
        cart_numericality_test(cart)

    end

    test "zip_code must be a number, and exactly 5 digits long" do
        cart = cart_suggestions(:korean)
        zip_code_test(cart)
    end
end
