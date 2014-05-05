class BillingInfo < ActiveRecord::Base
    belongs_to :payable, polymorphic: true
end
