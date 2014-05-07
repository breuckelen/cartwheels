class MenuItem < ActiveRecord::Base
    belongs_to :menu

    validates :description, :price, :menu, presence: true
    validates :price, numericality: true
    validates :image_url, format: {:with => /\w+\.(jpe?g|png|gif)/}
end
