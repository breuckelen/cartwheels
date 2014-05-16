require File.expand_path('../../test_helper', __FILE__)

class AdTest < ActiveSupport::TestCase
    fixtures :ads

    test "title description start_date end_date cart ad_type should be present" do
        ad = ads(:adHalal)
        presence_test(ad, :title)
        presence_test(ad, :description)
        presence_test(ad, :start_date)
        presence_test(ad, :end_date)
        presence_test(ad, :cart)
        presence_test(ad, :ad_type)
    end
end
