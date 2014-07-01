class SearchToken < ActiveRecord::Base
    # Relations
    has_and_belongs_to_many :search_lines, inverse_of: :search_tokens

    # Validations
    validates :term, presence: true

    def count
        return search_lines.count
    end
end
