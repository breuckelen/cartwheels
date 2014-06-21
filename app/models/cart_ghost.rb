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

    # For geospatial searches
    acts_as_mappable :lat_column_name => :lat,
        :lng_column_name => :lon

    # create a cart out of the cart ghost, adding a secret key
    # only can be done by admins and managers
    def approve
    end

    def self.search(text_query, location_query)
        if text_query.blank? and location_query.blank?
            order("created_at DESC")
        elsif text_query.blank?
            within(1, origin: location_query).order("created_at DESC")
        elsif location_query.blank?
            tq = "%#{text_query}%"
            where("name like ?", tq).order("created_at DESC")
        else
            tq = "%#{text_query}%"
            within(1, origin: location_query).where("name like ?", tq)
                .order("created_at DESC")
        end
    end
end
