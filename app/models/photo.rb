class Photo < ActiveRecord::Base
    # Relations
    belongs_to :author, polymorphic: true
    belongs_to :target, polymorphic: true, inverse_of: :photos
    has_attached_file :image, styles: { :medium => "300x300>",
        :small => "150x150>", :thumb => "100x100>" },
        :default_url => "/default.png",
        :url => "/system/:attachment/:id/:style/:filename"


    # Validations
    validates :target, :author, presence: true
    validates_attachment_content_type :image, :content_type => /\Aimage/

    def image_url
        image.url(:medium)
    end

    def image_url_large
        image.url(:original)
    end

    def image_url_small
        image.url(:small)
    end

    def image_url_thumb
        image.url(:thumb)
    end

    def as_json(options={})
        options[:only] ||= [:id, :caption, :target_id, :target_type, :created_at,
            :updated_at, :user_id]
        options[:methods] ||= [:image_url, :image_url_large, :image_url_small,
            :image_url_thumb]
        super(options)
    end

    def decode_from_data(data)
        begin
            file = Tempfile.new(['temp_image', '.jpg'])
            file.binmode
            Rails.logger.info(Base64.decode64(data))
            file.write Base64.decode64(data)
            file.rewind
            self.image = file
        ensure
            file.unlink
        end
    end
end
