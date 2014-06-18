class Ad < ActiveRecord::Base
    # Relations
    belongs_to :cart
    belongs_to :ad_type

    # Validations
    validates :title, :description, :start_date, :end_date, :cart, :ad_type,
        presence: true
end
