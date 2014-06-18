require File.expand_path('../cart_helper', __FILE__)

class CartGhostTest < ActiveSupport::TestCase
    fixtures :cart_ghosts

    test "name city borough permit_number zip_code lat lon \
    should be present" do
        cart = cart_ghosts(:korean)
        cart_presence_test(cart)
        presence_test(cart, :approved)
    end

    test "permit_number zip_code lat lon should be numbers" do
        cart = cart_ghosts(:korean)
        cart_numericality_test(cart)

    end

    test "zip_code should be a number and five digits long" do
        cart = cart_ghosts(:korean)
        zip_code_test(cart)
    end
end
