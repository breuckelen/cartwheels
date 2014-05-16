require 'test_helper'

class TagTest < ActiveSupport::TestCase
    fixtures :tags

    test "text count should be present" do
        tag = tags(:halalTag)
        presence_test(tag, :text)
        presence_test(tag, :count)
    end

    test "count should be a number" do
        tag = tags(:halalTag)
        numericality_test(tag, :count)
    end
end
