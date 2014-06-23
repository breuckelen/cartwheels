class SearchLine < ActiveRecord::Base
    # Relations
    belongs_to :search_history
    has_and_belongs_to_many :search_tokens

    # Validations
    validates :search_history, :search_tokens, presence: true

    def search_lines_search_tokens
        []
    end
end
