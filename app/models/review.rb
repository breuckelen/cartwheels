class Review < ActiveRecord::Base
    # Relations
    belongs_to :cart
    belongs_to :user

    # Validations
    validates :text, :rating, :cart, :user, presence: true
    validates :rating, numericality: true

    def as_json(options={})
        options[:except] ||= [:cart_id, :user_id]
        super(options)
    end
end
