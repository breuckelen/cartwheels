class Menu < ActiveRecord::Base
    belongs_to :cart
    has_many :menu_items
    has_many :menu_suggestions

    validates :cart, presence: true
end
