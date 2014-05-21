require File.expand_path('../../test_helper', __FILE__)

class SearchLineTest < ActiveSupport::TestCase
    fixtures :search_lines

    test "search_history search_tokens should be present" do
        line = search_lines(:jackLine)
        presence_test(line, :search_history)
    end
end
