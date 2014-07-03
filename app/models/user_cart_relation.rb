class UserCartRelation < ActiveRecord::Base
    # Relations
    belongs_to :user
    belongs_to :cart, inverse_of: :user_cart_relations

    # Validations
    validates :relation_type, :user, :cart, presence: true
    validates :relation_type, numericality: true

    def as_json(options={})
        options[:only] ||= [:id, :relation_type, :user_id, :cart_id]
        super(options)
    end
end
