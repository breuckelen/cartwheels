require File.expand_path('../../test_helper', __FILE__)

class SearchTokenTest < ActiveSupport::TestCase
    fixtures :search_tokens

    test "term and count may not be nil for a user" do
        token = search_tokens(:st101)
        presence_test(token, :term)
        presence_test(token, :count)
    end

    test "count must be a valid number" do
        token = search_tokens(:st101)
        numericality_test(token, :count)
    end
end
