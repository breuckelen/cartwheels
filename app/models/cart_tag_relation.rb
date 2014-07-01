class CartTagRelation < ActiveRecord::Base
    # Relations
    belongs_to :tag
    belongs_to :cart

    # Validations
    validates :tag, :cart, presence: true

    after_create :increment_tag

    def increment_tag
        tag.count += 1
        tag.save
        true
    end

    private :increment_tag
end
