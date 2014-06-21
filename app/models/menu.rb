class Menu < ActiveRecord::Base
    # Relations
    belongs_to :cart
    has_many :menu_items

    # Validations
    validates :cart, presence: true
end
