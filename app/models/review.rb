class Review < ActiveRecord::Base
    belongs_to :cart
    belongs_to :user

    validates :text, :rating, :cart, :user, presence: true
    validates :rating, numericality: true
end
