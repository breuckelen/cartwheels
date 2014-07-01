class Ad < ActiveRecord::Base
    # Relations
    belongs_to :cart
    belongs_to :ad_type

    # Validations
    validates :title, :description, :cart, :ad_type, presence: true
end
