require File.expand_path('../cart_helper', __FILE__)

class CartTest < ActiveSupport::TestCase
    fixtures :carts

    test "name city borough owner_secret permit_number zip_code lat lon\
    owner_secret should be present" do
        cart = carts(:halal)
        cart_presence_test(cart)
        presence_test(cart, :owner_secret)
    end

    test "owner_secret permit_number zip_code lat should be numbers" do
        cart = carts(:halal)
        cart_numericality_test(cart)
        numericality_test(cart, :owner_secret)
    end

    test "zip_code should be a number 5 digits long" do
        cart = carts(:halal)
        zip_code_test(cart)
    end
end
