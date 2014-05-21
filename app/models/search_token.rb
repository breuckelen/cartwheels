class SearchToken < ActiveRecord::Base
    # Relations
    has_and_belongs_to_many :search_lines

    # Validations
    validates :term, :count, :search_lines, presence: true
    validates :count, numericality: true
end
