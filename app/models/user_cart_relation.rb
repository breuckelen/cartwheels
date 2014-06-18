class UserCartRelation < ActiveRecord::Base
    # Relations
    belongs_to :user
    belongs_to :cart

    # Validations
    validates :relation_type, :user, :cart, presence: true
    validates :relation_type, numericality: true
end
