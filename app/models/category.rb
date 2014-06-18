class Category < ActiveRecord::Base
    # Relations
    has_many :cart_category_relations
    has_many :carts, through: :cart_category_relations

    # Validations
    validates :name, :count, presence: true
    validates :count, numericality: true
end
