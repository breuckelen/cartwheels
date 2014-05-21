class Menu < ActiveRecord::Base
    # Relations
    belongs_to :cart
    has_many :menu_items
    has_many :menu_ghosts

    # Validations
    validates :cart, presence: true
end
