class SearchLine < ActiveRecord::Base
    belongs_to :search_history
    has_and_belongs_to_many :search_tokens

    validates :search_history, :search_tokens, presence: true
end
