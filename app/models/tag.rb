class Tag < ActiveRecord::Base
    # Relations
    has_many :cart_tag_relations
    has_many :carts, :through => :cart_tag_relations

    # Validations
    validates :text, :count, presence: true
    validates :count, numericality: true
end
