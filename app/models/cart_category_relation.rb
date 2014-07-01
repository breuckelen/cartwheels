class CartCategoryRelation < ActiveRecord::Base
    # Relations
    belongs_to :category
    belongs_to :cart

    # Validations
    validates :category, :cart, presence: true

    after_create :increment_category

    def increment_category
        tag.count += 1
        tag.save
        true
    end

    private :increment_category
end
