class Clickthrough < ActiveRecord::Base
    belongs_to :user
    belongs_to :cart

    validates :count, :user, :cart, presence: true
    validates :count, numericality: true
end
