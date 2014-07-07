class Menu < ActiveRecord::Base
    # Relations
    belongs_to :cart
    has_many :menu_items, dependent: :destroy

    # Validations
    validates :cart, presence: true
end
