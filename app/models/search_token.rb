class SearchToken < ActiveRecord::Base
    has_and_belongs_to_many :search_lines

    validates :term, :count, :search_lines, presence: true
    validates :count, numericality: true
end
