class MenuSuggestion < ActiveRecord::Base
    belongs_to :menu
    has_and_belongs_to_many :users

    validates :description, :price, :image_url, :approved, :menu, presence: true
    validates :price, numericality: true
    validates :image_url, format: {:with => /\w+\.(jpe?g|png|gif)/}
    validates :users, length: { minimum: 1 }
end
