class Cart < ActiveRecord::Base
    has_one :menu
    has_many :ads
    has_many :photos
    has_many :menu_suggestions
    has_many :reviews
    has_and_belongs_to_many :followers, :class_name => "User"
    has_and_belongs_to_many :owners

    validates :name, :city, :borough, :permit_number, :zip_code, :owner_secret, :lat, :lon, presence: true
    validates :permit_number, :zip_code, :owner_secret, :lat, :lon, numericality: true
    validates :zip_code, format: {:with => /\A\d{5}\Z/}
end
