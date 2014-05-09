class UserCartRelation < ActiveRecord::Base
    belongs_to :user
    belongs_to :cart

    validates :relation_type, :user, :cart, presence: true
    validates :relation_type, numericality: true
end
