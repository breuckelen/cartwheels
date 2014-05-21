class Photo < ActiveRecord::Base
    # Relations
    belongs_to :target, polymorphic: true
    belongs_to :author, polymorphic: true

    # Validations
    validates :image_url, :target, :target_type, :author, :author_type,
        presence: true
    validates :image_url, format: {:with => /\w+\.(jpe?g|png|gif)/}
end
