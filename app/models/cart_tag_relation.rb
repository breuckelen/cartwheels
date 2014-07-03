class CartTagRelation < ActiveRecord::Base
    # Relations
    belongs_to :tag
    belongs_to :cart

    # Validations
    validates :tag, :cart, presence: true

    after_create :increment_tag

    def as_json(options={})
        options[:only] ||= [:id, :tag_id, :cart_id]
        super(options)
    end

    def increment_tag
        tag.count += 1
        tag.save
        true
    end

    private :increment_tag
end
