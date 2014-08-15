module Imageable
    extend ActiveSupport::Concern

    included do
        before_action :set_photo, only: [:create, :update]
    end

    def set_photo
        user = current_user
        user ||= current_owner
        name = params[:controller][0...-1]

        if image = params[name][:image]
            @photo = Photo.new(author: user, image: image)
        end

        if data = params[name][:encoded_image]
            @photo = Photo.new(author: user)
            @photo.decode_from_data(data)
        end
    end

    private :set_photo
end
