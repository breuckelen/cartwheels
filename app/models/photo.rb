class Photo < ActiveRecord::Base
    # Relations
    belongs_to :user
    belongs_to :target, polymorphic: true, inverse_of: :photos
    has_attached_file :image, styles: { :medium => "300x300>",
        :thumb => "100x100>" }, :default_url => "/uploads/:attachment/default.png",
        :url => "/uploads/:attachment/:id/:style/:filename"


    # Validations
    validates :target, :target_type, :user, presence: true
    validates_attachment_content_type :image, :content_type => /\Aimage/

    def image_url
        image.url(:medium)
    end
end
