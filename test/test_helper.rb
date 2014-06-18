ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    #
    # Note: You'll currently still have to declare fixtures explicitly in integration tests
    # -- they do not yet inherit this setting
    fixtures :all

    # Add more helper methods to be used by all tests here...

    def email_valid_test(obj)
        obj.email = "bob"

        assert obj.invalid?
        assert_equal "is invalid", obj.errors[:email][0]

        obj.email = "test@cartwheels.us"
        obj.invalid?
        assert_equal nil, obj.errors[:email][0]
    end

    def image_valid_test(obj)
        obj.image_url = "not_an_image.txt"
        assert obj.invalid?
        assert_equal "is invalid", obj.errors[:image_url][0]

        obj.image_url = "valid.jpeg"
        obj.invalid?
        assert_equal nil, obj.errors[:image_url][0]

        obj.image_url = "valid.jpg"
        obj.invalid?
        assert_equal nil, obj.errors[:image_url][0]

        obj.image_url = "valid.png"
        obj.invalid?
        assert_equal nil, obj.errors[:image_url][0]

        obj.image_url = "valid.gif"
        obj.invalid?
        assert_equal nil, obj.errors[:image_url][0]
    end

    def zip_code_test(obj)
        obj.zip_code = "bill"

        assert obj.invalid?
        assert_equal "is not a number", obj.errors[:zip_code][0]

        obj.zip_code = 1121
        obj.invalid?
        assert_equal "is invalid", obj.errors[:zip_code][0]

        obj.zip_code = 11217
        obj.invalid?
        assert_equal nil, obj.errors[:zip_code][0]

        obj.zip_code = 112171
        obj.invalid?
        assert_equal "is invalid", obj.errors[:zip_code][0]
    end

    def presence_test(obj, attr)
        obj.send((attr.to_s + "=").to_sym, nil)

        assert obj.invalid?
        assert_equal "can't be blank", obj.errors[attr][0]
    end

    def numericality_test(obj, attr)
        obj.send((attr.to_s + "=").to_sym, "fred")

        assert obj.invalid?
        assert_equal "is not a number", obj.errors[attr][0]
    end
end
