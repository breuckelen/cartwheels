require File.expand_path('../cart_helper', __FILE__)

class CartSuggestionTest < ActiveSupport::TestCase
    fixtures :cart_suggestions

    test "name city borough permit_number zip_code lat lon \
    should be present" do
        cart = cart_suggestions(:korean)
        cart_presence_test(cart)
        presence_test(cart, :approved)
    end

    test "permit_number zip_code lat lon should be numbers" do
        cart = cart_suggestions(:korean)
        cart_numericality_test(cart)

    end

    test "zip_code should be a number and five digits long" do
        cart = cart_suggestions(:korean)
        zip_code_test(cart)
    end
end
