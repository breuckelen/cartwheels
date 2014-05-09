class UserCartRelationTest < ActiveSupport::TestCase
    fixtures :user_cart_relations

    test "relation_type, user, cart should be present" do
        rel = user_cart_relations(:benFavoriteHalal)
        presence_test(rel, :relation_type)
        presence_test(rel, :user)
        presence_test(rel, :cart)
    end

    test "relation_type should be a number" do
        rel = user_cart_relations(:benFavoriteHalal)
        numericality_test(rel, :relation_type)
    end
end
