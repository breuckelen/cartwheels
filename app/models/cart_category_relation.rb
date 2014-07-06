class CartCategoryRelation < ActiveRecord::Base
    # Relations
    belongs_to :category
    belongs_to :cart

    # Validations
    validates :category, :cart, presence: true

    def as_json(options={})
        options[:only] ||= [:id, :category_id, :cart_id]
        super(options)
    end
end
