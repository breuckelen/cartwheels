require File.expand_path('../../test_helper', __FILE__)

class SearchTokenTest < ActiveSupport::TestCase
    fixtures :search_tokens

    test "term, count should be present" do
        token = search_tokens(:halalToken)
        presence_test(token, :term)
        presence_test(token, :count)
    end

    test "count should be a number" do
        token = search_tokens(:halalToken)
        numericality_test(token, :count)
    end
end
