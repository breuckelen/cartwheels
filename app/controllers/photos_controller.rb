class PhotosController < ApplicationController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_action :set_photo, only: [:show, :edit, :update, :destroy]

    def index
    end

    # show a photo
    def show
    end

    # form for creating a new photo for a cart
    def new
        @photo = Photo.new
    end

    def edit
    end

    # create a new photo for a cart
    def create
        if photo_params[:encoded_image].nil?
            @photo = current_user.photos.build(photo_params)
        else
            new_params = photo_params
            decoded_file = StringIO.new(Base64.decode64(new_params.delete(:encoded_image)))
            @photo = current_user.photos.build(new_params)
            @photo.decode_from_data(decoded_file)
        end

        if params[:cart_id]
            @photo.target = Cart.find(params[:cart_id])
        elsif params[:user_id]
            @photo.target = User.find(params[:user_id])
        end

        respond_to do |format|
            if @photo.save
                format.html { redirect_to @photo,
                    notice: 'Photo was succesfully created.' }
                format.json { render status: :created,
                    location: @photo,
                    :json => { :success => true, url: @photo.image_url }}
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    :json => { :success => false, :errors => @photo.errors}}
            end
        end
    end

    def update
        respond_to do |format|
            if @photo.update(photo_params)
                format.html { redirect_to @photo,
                    notice: 'Photo was succesfully updated.' }
                format.json { render :show, status: :ok,
                    location: @photo,
                    :json => { :success => true }}
            else
                format.html { render :edit }
                format.json { render status: :unprocessable_entity,
                    :json => { :success => false, :errors => @photo.errors}}
            end
        end
    end

    def destroy
        cart = @photo.cart

        respond_to do |format|
            if current_user == @photo.user or current_user.has_role? :admin
                @photo.destroy

                format.html { redirect_to cart,
                    notice: 'Photo was successfully destroyed.' }
                format.json { render json: {
                    success: true } }
            else
                format.html { redirect_to cart,
                    notice: 'You do not have permission to perform this action.' }
                format.json { render json: {
                    success: false }
                }
            end
        end
    end

    respond_to :json
    def data
        if params[:photo].empty?
            @photos = Photo.limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        else
            @photos = Photo.where(data_params)
                .limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        end

        render :status => 200,
            :json => { :success => true, :data => @photos }
    end

    def data_params
        params.require(:photo).permit(:id, :user_id, :target_id, :target_type)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def photo_params
        params.require(:photo).permit(:target_id, :target_type, :image, :encoded_image,
            :caption)
    end

    def set_photo
        @photo = Photo.find(params[:id])
    end

    private :data_params
    private :search_params
    private :photo_params
    private :set_photo
end
