class Category < ActiveRecord::Base
    # Relations
    has_many :cart_category_relations
    has_many :carts, through: :cart_category_relations

    # Validations
    validates :name, presence: true

    def count
        return CartCategoryRelation.where(category_id: self.id).count
    end
end
