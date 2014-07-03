class SearchLine < ActiveRecord::Base
    # Relations
    belongs_to :search_history
    has_and_belongs_to_many :search_tokens, inverse_of: :search_lines

    # Validations
    validates :search_history, presence: true

    def as_json(options={})
        options[:only] ||= [:id, :search_history_id]
        options[:include] ||= {
            search_tokens: {only: [:term]}
        }
        super(options)
    end

    def search_lines_search_tokens
        []
    end
end
