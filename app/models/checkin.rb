class Checkin < ActiveRecord::Base
    belongs_to :user, polymorphic: true
    belongs_to :cart
    has_many :photos, as: :target, inverse_of: :target

    validates :user, :cart, :lat, :lon, presence: true

    after_create :update_cart

    # For geospatial searches
    acts_as_mappable :lat_column_name => :lat,
        :lng_column_name => :lon

    def update_cart
        cart.save
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
end
