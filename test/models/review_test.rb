require File.expand_path('../../test_helper', __FILE__)

class ReviewTest < ActiveSupport::TestCase
    fixtures :reviews

    test "text, rating should be present" do
        rev = reviews(:halalReview)
        presence_test(rev, :text)
        presence_test(rev, :rating)
        presence_test(rev, :cart)
        presence_test(rev, :user)
    end

    test "rating should be a number" do
        rev = reviews(:halalReview)
        numericality_test(rev, :rating)
    end
end
