require File.expand_path('../../test_helper', __FILE__)
class MenuSuggestionTest < ActiveSupport::TestCase
    fixtures :menu_suggestions

    test "description and price may not be nil for a user" do
        item = menu_suggestions(:coffee)
        presence_test(item, :description)
        presence_test(item, :price)
        presence_test(item, :approved)
    end

    test "price must be a valid number" do
        item = menu_suggestions(:coffee)
        numericality_test(item, :price)
    end

    test "image_url must have a valid extension" do
        item = menu_suggestions(:coffee)
        image_valid_test(item)
    end
end
