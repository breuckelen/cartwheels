require 'test_helper'

class ClickthroughTest < ActiveSupport::TestCase
    fixtures :clickthroughs

    test "count, user, cart should be present" do
        click = clickthroughs(:halalClick)
        presence_test(click, :count)
        presence_test(click, :user)
        presence_test(click, :cart)
    end

    test "count should be a number" do
        click = clickthroughs(:halalClick)
        numericality_test(click, :count)
    end
end
