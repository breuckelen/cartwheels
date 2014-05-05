class Owner < ActiveRecord::Base
    has_one :billing_info, as: :payable
    has_and_belongs_to_many :carts
end
