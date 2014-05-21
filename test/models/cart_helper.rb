require File.expand_path('../../test_helper', __FILE__)

class ActiveSupport::TestCase
    def cart_presence_test(obj)
        presence_test(obj, :name)
        presence_test(obj, :city)
        presence_test(obj, :borough)
        presence_test(obj, :permit_number)
        presence_test(obj, :zip_code)
        presence_test(obj, :lat)
        presence_test(obj, :lon)
    end

    def cart_numericality_test(obj)
        numericality_test(obj, :permit_number)
        numericality_test(obj, :zip_code)
        numericality_test(obj, :lat)
        numericality_test(obj, :lon)
    end
end
