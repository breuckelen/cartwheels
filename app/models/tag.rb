class Tag < ActiveRecord::Base
    # Relations
    has_many :cart_tag_relations
    has_many :carts, :through => :cart_tag_relations

    # Validations
    validates :name, presence: true

    def count
        return CartTagRelation.where(tag_id: self.id).count
    end
end
