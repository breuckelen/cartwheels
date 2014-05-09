require 'test_helper'

class CartTagRelationTest < ActiveSupport::TestCase
    fixtures :cart_tag_relations

    test "tag, cart, cart_type should be present" do
        rel = cart_tag_relations(:one)
        presence_test(rel, :tag)
        presence_test(rel, :cart)
        presence_test(rel, :cart_type)
    end
end
