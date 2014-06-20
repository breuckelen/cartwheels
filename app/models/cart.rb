class Cart < ActiveRecord::Base
    # Relations
    belongs_to :upload
    has_one :menu
    has_many :ads
    has_many :menu_ghosts
    has_many :reviews
    has_many :clickthroughs
    has_many :photos, as: :target, inverse_of: :target, dependent: :destroy
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
    before_validation :reverse_geocode

    reverse_geocoded_by :lat, :lon do |obj, results|
        if geo = results.first
            obj.city = geo.city
            obj.zip_code = geo.postal_code
        end
    end

    # For geospatial searches
    acts_as_mappable :lat_column_name => :lat,
        :lng_column_name => :lon

    def as_json(options={})
        options[:except] ||= [:upload_id, :owner_secret]
        super(options)
    end

    def self.search(text_query, location_query)
        if text_query.blank? and location_query.blank?
            all
        elsif text_query.blank?
            within(1, origin: location_query)
        else
            tq = "%#{text_query}%"
            within(1, origin: location_query).order("created_at DESC")
                .where("name like ?", tq)
        end
    end

    # Get most popular carts (highest ratings, most clickthroughs)
    def self.trending
    end
end
