class Cart < ActiveRecord::Base
    # Relations
    has_one :menu
    has_many :ads
    has_many :reviews
    has_many :clickthroughs
    has_many :photos, as: :target, inverse_of: :target
    has_many :user_cart_relations, inverse_of: :cart
    has_many :users, through: :user_cart_relations
    has_many :cart_tag_relations
    has_many :tags, through: :cart_tag_relations
    has_many :cart_category_relations
    has_many :categories, through: :cart_category_relations
    has_many :notifications
    has_and_belongs_to_many :owners

    # Validations
    validates :name, :city, :permit_number, :zip_code, :lat, :lon,
        presence: true
    validates :permit_number, :zip_code, :lat, :lon, numericality: true
    validates :permit_number, uniqueness: true
    validates :zip_code, format: {:with => /\A\d{5}\Z/}

    # Filters
    before_validation :reverse_geocode
    before_create :build_default_menu

    # Reverse geocoding
    reverse_geocoded_by :lat, :lon do |obj, results|
        if geo = results.first
            obj.city = geo.city
            obj.zip_code = geo.postal_code
        end
    end

    # For geospatial searches
    acts_as_mappable :lat_column_name => :lat,
        :lng_column_name => :lon

    def build_default_menu
        build_menu
        true
    end

    def carts_owners
        []
    end

    # Replace type 0 with a constant for uploader
    def uploader
        user_cart_relations.where(relation_type: 0).first.user
    end

    # Get first image url
    def admin_image_url
        if photos.first.nil?
            return '/system/images/default.png'
        else
            return photos.first.image_url_thumb
        end
    end

    def as_json(options={})
        options[:only] ||= [:id, :name, :city, :permit_number, :zip_code,
            :description, :lat, :lon]
        options[:include] ||= {
            :photos => { :only => :null, :methods => [:image_url] }
        }
        super(options)
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

    # Get most popular carts (highest ratings, most clickthroughs)
    def self.trending
    end

    private :build_default_menu
end
