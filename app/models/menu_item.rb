class MenuItem < ActiveRecord::Base
    # Relations
    belongs_to :menu
    has_one :photo, as: :target, inverse_of: :target

    # Validations
    validates :description, :price, :menu, presence: true
    validates :price, numericality: true
end
