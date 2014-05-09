class MenuItem < ActiveRecord::Base
    belongs_to :menu
    has_one :photo, as: :target

    validates :description, :price, :menu, presence: true
    validates :price, numericality: true
end
