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
    has_many :checkins, dependent: :destroy
    has_many :hours
    has_many :cart_owner_relations
    has_many :owners, through: :cart_owner_relations
    has_many :tweets

    # Validations
    validates :name, :city, :zip_code, :address, :lat, :lon,
        presence: true
    validates :zip_code, :lat, :lon, :popularity, numericality: true
    validates :zip_code, format: {:with => /\A\d{5}\Z/}
    validates :green, :inclusion => {:in => [0, 1, 2]}
    validates :permit_number, presence: true, unless: :twitter_handle?
    validates :permit_number, uniqueness: true, unless: :twitter_handle?
    validates :permit_number, numericality: true, unless: :twitter_handle?

    # Filters
    before_validation :update_popularity, :update_rating, :update_location
    before_validation :reverse_geocode
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
        recent_checkins = checkins.where(
            created_at: (Time.now - 5.day)..Time.now)
            .limit(4)
            .order('created_at DESC')

        if recent_checkins.count > 2
            new_lat = self.lat
            new_lon = self.lon

            recent_checkins.each do |c|
                if recent_checkins.within(0.2, origin: c).count\
                        > recent_checkins.count / 2
                    new_lat = c.lat
                    new_lon = c.lon
                    break
                end
            end

            self.lat = new_lat
            self.lon = new_lon
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
            :description, :rating, :lat, :lon, :address]
        options[:include] ||= {
            :photos => { :only => :null, :methods => [:image_url,
                :image_url_large] }
        }
        super(options)
    end

    def self.search(sort_by, text_query, location_query, cats, box)
        if box.empty?
            if text_query.blank? and location_query.blank?
                return order("#{sort_by} DESC, created_at DESC")
            elsif text_query.blank?
                return by_distance(origin: location_query)
                    .order("#{sort_by} DESC, created_at DESC")
            elsif location_query.blank?
                tq = "%#{text_query}%"
                carts = Cart.arel_table
                categories = Category.arel_table

                return where("name LIKE ?", tq)
                    .order("#{sort_by} DESC, created_at DESC")
            else
                tq = "%#{text_query}%"
                carts = Cart.arel_table
                categories = Category.arel_table

                return by_distance(origin: location_query)
                    .where("name LIKE ?", tq)
                    .order("#{sort_by} DESC, created_at DESC")
            end
        else
            tq = "%#{text_query}%"
            carts = Cart.arel_table

            if "all".in? cats
                if text_query.blank?
                    return in_bounds(box).by_distance(origin: location_query)
                else
                    return in_bounds(box).by_distance(origin: location_query)
                        .where("name LIKE ?", tq)
                end
            else
                categories = Category.arel_table

                if text_query.blank?
                    return in_bounds(box).by_distance(origin: location_query)
                        .joins(cart_category_relations: :category)
                            .where(categories[:name].eq_any(cats))
                else
                    return in_bounds(box).by_distance(origin: location_query)
                        .joins(cart_category_relations: :category)
                            .where(categories[:name].eq_any(cats))
                            .where("name LIKE ?", tq)
                end
            end
        end
    end

    def self.skip_updates
        skip_callback(:validation, :before, :update_popularity)
        skip_callback(:validation, :before, :update_rating)
        skip_callback(:validation, :before, :update_location)
    end

    def self.set_updates
        set_callback(:validation, :before, :update_popularity)
        set_callback(:validation, :before, :update_rating)
        set_callback(:validation, :before, :update_location)
    end

    # Get most popular carts (highest ratings, most clickthroughs)
    def self.trending
    end

    def self.collect_tweets
        where.not(twitter_handle: "").where.not(twitter_handle: nil).each\
                do |cart|
            handle = cart.twitter_handle.split('@')[1]
            options = {count: 50, include_rts: true}

            begin
                $client.user_timeline(handle, options).each do |tweet|
                    begin
                        cart.tweets.create(tweet_id: tweet.id, text: tweet.text,
                            date: tweet.created_at.to_date)
                    rescue Exception => e
                    end
                end
            rescue Exception => e
            end
        end
    end

    private :build_default_menu
end
