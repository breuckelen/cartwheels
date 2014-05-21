class Clickthrough < ActiveRecord::Base
    # Relations
    belongs_to :user
    belongs_to :cart

    # Validations
    validates :count, :user, :cart, presence: true
    validates :count, numericality: true
end
