class CartTagRelation < ActiveRecord::Base
    # Relations
    belongs_to :tag
    belongs_to :cart

    # Validations
    validates :tag, :cart, presence: true

    def as_json(options={})
        options[:only] ||= [:id, :tag_id, :cart_id]
        super(options)
    end
end
