class SearchHistory < ActiveRecord::Base
    belongs_to :user
    has_many :search_items
end
