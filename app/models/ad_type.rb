class AdType < ActiveRecord::Base
    # Relations
    has_many :ads

    # Validations
    validates :title, :description, :duration, :price, presence: true
    validates :price, :duration, numericality: true
end
