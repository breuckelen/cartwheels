class Photo < ActiveRecord::Base
    # Relations
    belongs_to :user
    belongs_to :target, polymorphic: true, inverse_of: :photos
    has_attached_file :image, styles: { :medium => "300x300>",
        :small => "150x150>", :thumb => "100x100>" },
        :default_url => "/system/:attachment/default.png",
        :url => "/system/:attachment/:id/:style/:filename"


    # Validations
    validates :target, :target_type, :user, presence: true
    validates_attachment_content_type :image, :content_type => /\Aimage/

    def image_url
        image.url(:medium)
    end

    def image_url_small
        image.url(:small)
    end

    def image_url_thumb
        image.url(:thumb)
    end
end
