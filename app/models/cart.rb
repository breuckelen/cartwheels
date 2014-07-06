class Cart < ActiveRecord::Base
    # Relations
    has_one :menu, dependent: :destroy
    has_many :ads, dependent: :destroy
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
    has_many :checkins
    has_many :hours
    has_and_belongs_to_many :owners

    # Validations
    validates :name, :city, :permit_number, :zip_code, :address, :lat, :lon,
        presence: true
    validates :permit_number, :zip_code, :lat, :lon, :popularity, numericality: true
    validates :permit_number, uniqueness: true
    validates :zip_code, format: {:with => /\A\d{5}\Z/}
    validates :green, :inclusion => {:in => [0, 1, 2]}

    # Filters
    before_validation :reverse_geocode
    before_save :update_popularity, :update_rating, :update_location
    before_create :build_default_menu

    # Reverse geocoding
    reverse_geocoded_by :lat, :lon do |obj, results|
        if geo = results.first
            obj.city = geo.city
            obj.zip_code = geo.postal_code
            obj.address = geo.address.split(', ')[0..1].join(', ')
        end
    end

    # For geospatial searches
    acts_as_mappable :lat_column_name => :lat,
        :lng_column_name => :lon

    def carts_owners
        []
    end

    def build_default_menu
        build_menu
        true
    end

    def update_popularity
        scale_factor = 2.0
        if checkins.last
            scale_factor = Math.log(
                (DateTime.now.to_date - checkins.last.created_at.to_date) + 5, 5)
        elsif reviews.last
            scale_factor = Math.log(
                (DateTime.now.to_date - reviews.last.created_at.to_date) + 5, 5)
        end

        self.popularity = (reviews.count + checkins.count.to_f / 2.0) / scale_factor
    end

    def update_rating
        if reviews.last
            self.rating = reviews.sum(:rating) / reviews.count.to_f
        else
            self.rating = 0
        end
    end

    def update_location
        if checkins.last
            recent_checkins = checkins.where(
                created_at: (Time.now - 5.day)..Time.now).limit(20)

            lat_lon = recent_checkins.each do |c|
                if recent_checkins.within(0.1, origin: c).count\
                        > recent_checkins.count / 2
                    return [c.lat, c.lon]
                end
            end

            self.lat = lat_lon[0]
            self.lon = lat_lon[1]
        end
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

    def self.search(sort_by, text_query, location_query)
        if text_query.blank? and location_query.blank?
            order("#{sort_by} DESC, created_at DESC")
        elsif text_query.blank?
            within(1,
                origin: location_query).order("#{sort_by} DESC, created_at DESC")
        elsif location_query.blank?
            tq = "%#{text_query}%"
            where("name like ?", tq).order("#{sort_by} DESC, created_at DESC")
        else
            tq = "%#{text_query}%"
            within(1, origin: location_query).where("name like ?", tq)
                .order("#{sort_by} DESC, created_at DESC")
        end
    end

    # Get most popular carts (highest ratings, most clickthroughs)
    def self.trending
    end

    private :build_default_menu
end
