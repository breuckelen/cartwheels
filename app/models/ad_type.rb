class AdType < ActiveRecord::Base
    has_many :ads

    validates :title, :description, :duration, :price, presence: true
    validates :price, :duration, numericality: true
end
