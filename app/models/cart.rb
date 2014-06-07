class Cart < ActiveRecord::Base
    # Relations
    belongs_to :upload
    has_one :menu
    has_many :ads
    has_many :menu_ghosts
    has_many :reviews
    has_many :clickthroughs
    has_many :photos, as: :target
    has_many :user_cart_relations
    has_many :users, through: :user_cart_relations
    has_many :cart_tag_relations, as: :cart
    has_many :tags, through: :cart_tag_relations
    has_many :cart_category_relations, as: :cart
    has_many :categories, through: :cart_category_relations
    has_and_belongs_to_many :owners

    # Validations
    validates :name, :city, :permit_number, :zip_code, :lat, :lon,
        presence: true
    validates :permit_number, :zip_code, :lat, :lon, numericality: true
    validates :permit_number, uniqueness: true
    validates :zip_code, format: {:with => /\A\d{5}\Z/}

    # Reverse geocoding
    reverse_geocoded_by :lat, :lon do |obj, results|
        if geo = results.first
            obj.city = geo.city
            obj.zip_code = geo.postal_code
        end
    end

    # Callbacks
    before_validation :reverse_geocode

    # Get most popular carts (highest ratings, most clickthroughs)
    def self.trending
    end
end
