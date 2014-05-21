class SearchHistory < ActiveRecord::Base
    # Relations
    belongs_to :user
    has_many :search_lines

    # Validations
    validates :user, presence: true
end
