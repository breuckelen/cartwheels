class Ad < ActiveRecord::Base
    # Relations
    belongs_to :cart
    belongs_to :ad_type

    # Validations
    validates :title, :description, :cart, :ad_type, presence: true

    def as_json(options={})
        options[:only] ||= [:id, :title, :description, :price, :cart_id,
            :ad_type_id]
        super(options)
    end
end
