class CartCategoryRelation < ActiveRecord::Base
    # Relations
    belongs_to :category
    belongs_to :cart

    # Validations
    validates :category, :cart, presence: true

    after_create :increment_category

    def as_json(options={})
        options[:only] ||= [:id, :category_id, :cart_id]
        super(options)
    end

    def increment_category
        tag.count += 1
        tag.save
        true
    end

    private :increment_category
end
