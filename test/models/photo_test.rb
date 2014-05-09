require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
    fixtures :photos

    test "image_url, target, target_type, author should be present" do
        photo = photos(:one)
        presence_test(photo, :image_url)
        presence_test(photo, :target)
        presence_test(photo, :target_type)
        presence_test(photo, :author)
    end

    test "image_url should be valid" do
        photo = photos(:one)
        image_valid_test(photo)
    end
end
