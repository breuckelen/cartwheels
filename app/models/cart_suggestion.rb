class CartSuggestion < ActiveRecord::Base
    has_many :photos, as: :target
    has_many :cart_tag_relations, as: :cart
    has_many :tags, through: :cart_tag_relations
    has_and_belongs_to_many :users

    validates :name, :city, :borough, :permit_number, :zip_code, :lat, :lon,
        :approved, presence: true
    validates :permit_number, :zip_code, :lat, :lon, numericality: true
    validates :zip_code, numericality: true, format: {:with => /\A\d{5}\Z/}
    validates :users, length: { minimum: 1 }
end
