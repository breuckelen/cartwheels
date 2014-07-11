class Category < ActiveRecord::Base
    # Relations
    has_many :cart_category_relations, dependent: :destroy
    has_many :carts, through: :cart_category_relations

    # Validations
    validates :name, presence: true
    validates :name, uniqueness: true

    before_validation :update_count

    def update_count
        self.count = CartCategoryRelation.where(category_id: self.id).count
    end

    def as_json(options={})
        options[:only] ||= [:id, :name]
        super(options)
    end

    def self.most_popular(limit)
        order('count DESC').limit(limit)
    end
end
