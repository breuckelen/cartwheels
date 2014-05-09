class CartTagRelation < ActiveRecord::Base
    belongs_to :tag
    belongs_to :cart, polymorphic: true

    validates :tag, :cart, :cart_type, presence: true
end
