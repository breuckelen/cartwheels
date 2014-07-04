class Hour < ActiveRecord::Base
    belongs_to :cart

    validates :day, :start, :end, :cart, presence: true
    validates :day, numericality: true
    validates :day, uniqueness: {:scope => :cart_id,
        :message => "Only one hours object may exist per day."}
    validates :start, :end,  format: {:with => /\A\d{4}\Z/}
end
