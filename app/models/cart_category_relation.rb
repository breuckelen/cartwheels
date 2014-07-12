class CartCategoryRelation < ActiveRecord::Base
    # Relations
    belongs_to :category
    belongs_to :cart

    # Validations
    validates :category, :cart, presence: true
    validates :category_id, uniqueness: {:scope => :cart_id,
        :message => "Category may only belong to cart once."}

    after_create :update_category

    def update_category
        category.save
    end

    def as_json(options={})
        options[:only] ||= [:id, :category_id, :cart_id]
        super(options)
    end
end
