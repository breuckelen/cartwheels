class CartGhost < ActiveRecord::Base
    # Relations
    has_many :photos, as: :target
    has_many :cart_tag_relations, as: :cart
    has_many :tags, through: :cart_tag_relations
    has_many :cart_category_relations, as: :cart
    has_many :categories, through: :cart_category_relations
    has_and_belongs_to_many :users

    # Validations
    validates :name, :city, :borough, :zip_code, :lat, :lon, presence: true
    validates :zip_code, :permit_number, :lat, :lon, numericality: true
    validates :zip_code, format: {:with => /\A\d{5}\Z/}
    validates :users, length: { minimum: 1 }

    # create a cart out of the cart ghost, adding a secret key
    # only can be done by admins and managers
    def approve
    end
end
