class Tag < ActiveRecord::Base
    # Relations
    has_many :cart_tag_relations
    has_many :carts, :through => :cart_tag_relations

    # Validations
    validates :name, presence: true

    before_validation :update_count

    def update_count
        self.count = CartTagRelation.where(tag_id: self.id).count
    end

    def as_json(options={})
        options[:only] ||= [:id, :name]
        super(options)
    end
end
