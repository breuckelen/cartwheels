class CartCategoryRelation < ActiveRecord::Base
    # Relations
    belongs_to :category
    belongs_to :cart, polymorphic: true

    # Validations
    validates :category, :cart, :cart_type, presence: true
end
