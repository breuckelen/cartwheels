require File.expand_path('../../test_helper', __FILE__)

class MenuSuggestionTest < ActiveSupport::TestCase
    fixtures :menu_suggestions

    test "description price should be present" do
        item = menu_suggestions(:coffee)
        presence_test(item, :description)
        presence_test(item, :price)
        presence_test(item, :approved)
    end

    test "price should be a number" do
        item = menu_suggestions(:coffee)
        numericality_test(item, :price)
    end
end
