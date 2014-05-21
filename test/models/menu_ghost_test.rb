require File.expand_path('../../test_helper', __FILE__)

class MenuGhostTest < ActiveSupport::TestCase
    fixtures :menu_ghosts

    test "description price should be present" do
        item = menu_ghosts(:coffee)
        presence_test(item, :description)
        presence_test(item, :price)
        presence_test(item, :approved)
    end

    test "price should be a number" do
        item = menu_ghosts(:coffee)
        numericality_test(item, :price)
    end
end
