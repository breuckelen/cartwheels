class PhotosController < ApplicationController
    # show photos belonging to a cart
    def index
    end

    # show a photo
    def show
    end

    # form for creating a new photo for a cart
    def new
    end

    # edit a photo
    def edit
    end

    # create a new photo for a cart
    def create
    end

    # update a photo
    def update
    end

    # destroy a photo
    def destroy
    end

    def photo_params
        params.require(:photo).permit(:image)
    end

    private :photo_params
end
