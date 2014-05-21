class CartTagRelation < ActiveRecord::Base
    # Relations
    belongs_to :tag
    belongs_to :cart, polymorphic: true

    # Validations
    validates :tag, :cart, :cart_type, presence: true
end
