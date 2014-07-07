class Review < ActiveRecord::Base
    # Relations
    belongs_to :cart
    belongs_to :user

    # Validations
    validates :text, :rating, :cart, :user, presence: true
    validates :rating, numericality: true, inclusion: {:in => 1..5}
    validates :user_id, uniqueness: {:scope => :cart_id,
        :message => "Users may only write one review per cart."}

    after_create :update_cart

    def update_cart
        cart.save
    end

    def as_json(options={})
        options[:only] ||= [:id, :text, :rating, :cart_id, :user_id, :created_at, :updated_at]
        super(options)
    end

    def self.search(text_query, location_query)
        tq = "%#{text_query}%"
        if text_query.blank? and location_query.blank?
            order("created_at DESC")
        elsif text_query.blank?
            joins(:cart).merge(
                Cart.within(1, origin: location_query)
            ).order("created_at DESC")
        elsif location_query.blank?
            joins(:cart).merge(
                Cart.where("name like ?", tq)
            ).order("created_at DESC")
        else
            joins(:cart).merge(
                Cart.within(1, origin: location_query)
                .where("name like ?", tq)
            ).order("created_at DESC")
        end
    end
end
