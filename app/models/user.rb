class User < ActiveRecord::Base
    has_one :search_history
    has_one :billing_info, as: :payable
    has_many :reviews
    has_and_belongs_to_many :favorites, :class_name => "Cart"
    has_and_belongs_to_many :cart_suggestions
    has_and_belongs_to_many :menu_suggestions
end
