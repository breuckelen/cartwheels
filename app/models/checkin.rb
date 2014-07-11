class Checkin < ActiveRecord::Base
    belongs_to :user, polymorphic: true
    belongs_to :cart
    has_many :photos, as: :target, inverse_of: :target

    validates :user, :cart, :lat, :lon, presence: true

    before_validation :check_user
    after_create :update_cart

    # For geospatial searches
    acts_as_mappable :lat_column_name => :lat,
        :lng_column_name => :lon

    def update_cart
        cart.save
    end

    def check_user
        cs = Checkin.where(user: self.user, cart: self.cart,
            created_at: (Time.now - 1.day)..Time.now)
        if cs.count > 0
            self.errors.add(:user,
                "Can't checkin at a cart more than once a day")
        end
    end

    def as_json(options={})
        options[:only] ||= [:id, :lat, :lon, :user_id, :user_type, :cart_id]
    end

    def self.search(text_query, location_query)
        tq = "%#{text_query}%"
        if text_query.blank? and location_query.blank?
            order("created_at DESC")
        elsif text_query.blank?
            within(1, origin: location_query).order("created_at DESC")
        elsif location_query.blank?
            joins(:cart).merge(Cart.where("name like ?", tq))
            .order("created_at DESC")
        else
            within(1, origin: location_query)
            .joins(:cart).merge(Cart.where("name like ?", tq))
            .order("created_at DESC")
        end
    end

    private :check_user
end
