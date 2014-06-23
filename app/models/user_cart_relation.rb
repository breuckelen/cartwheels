class UserCartRelation < ActiveRecord::Base
    # Relations
    belongs_to :user
    belongs_to :cart, inverse_of: :user_cart_relations

    # Validations
    validates :relation_type, :user, :cart, presence: true
    validates :relation_type, numericality: true
end
