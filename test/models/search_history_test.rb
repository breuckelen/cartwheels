require File.expand_path('../../test_helper', __FILE__)

class SearchHistoryTest < ActiveSupport::TestCase
    fixtures :search_histories

    test "user should be present" do
        jack = search_histories(:jackHistory)
        presence_test(jack, :user)
    end
end
