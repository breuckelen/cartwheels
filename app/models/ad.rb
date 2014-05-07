class Ad < ActiveRecord::Base
    belongs_to :cart
    belongs_to :ad_type

    validates :title, :description, :start_date, :end_date, :cart, :ad_type, presence: true
end
