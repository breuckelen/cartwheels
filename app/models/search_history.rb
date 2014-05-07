class SearchHistory < ActiveRecord::Base
    belongs_to :user
    has_many :search_lines

    validates :user, presence: true
end
