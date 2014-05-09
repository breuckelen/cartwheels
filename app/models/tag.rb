class Tag < ActiveRecord::Base
    has_and_belongs_to_many :carts

    validates :text, :count, presence: true
    validates :count, numericality: true
end
