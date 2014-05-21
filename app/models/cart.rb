class Cart < ActiveRecord::Base
    # Relations
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
    has_and_belongs_to_many :owners

    # Validations
    validates :name, :city, :borough, :permit_number, :zip_code, :owner_secret,
        :lat, :lon, presence: true
    validates :permit_number, :zip_code, :owner_secret, :lat, :lon,
        numericality: true
    validates :zip_code, format: {:with => /\A\d{5}\Z/}
end
