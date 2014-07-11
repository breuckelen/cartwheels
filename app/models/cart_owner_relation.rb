class CartOwnerRelation < ActiveRecord::Base
    belongs_to :cart
    belongs_to :owner

    validates :cart_id, uniqueness: {:scope => :owner_id,
        :message => "Only allowed to claim the cart once."}
end
