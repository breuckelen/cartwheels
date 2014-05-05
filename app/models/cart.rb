class Cart < ActiveRecord::Base
    has_many :ads
    has_many :photos
    has_many :menu_suggestions
    has_many :reviews
    has_and_belongs_to_many :followers, :class_name => "User"
    has_and_belongs_to_many :owners
end
