class UploadsController < ApplicationController
    before_action :set_upload, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_user!

    # GET /uploads
    # GET /uploads.json
    def index
        # Get carts updated in the last day
        @uploads = Upload.where(updated_at: (Time.now - 1.day)..Time.now)
    end

    # GET /uploads/new
    def new
        @upload = Upload.new
        @cart = @upload.build_cart
    end

    # GET /uploads/1/edit
    def edit
        @cart = @upload.cart
    end

    # POST /uploads
    # POST /uploads.json
    def create
        @upload = current_user.uploads.build
        @cart = @upload.build_cart(upload_params[:cart_attributes])

        if image = upload_params[:image]
            @cart.photos.build(user: current_user, image: image)
        end

        respond_to do |format|
            if @upload.save
                format.html { redirect_to uploads_path,
                    notice: 'Cart was succesfully created.' }
                format.json { render :show, status: :created,
                    location: @upload }
            else
                format.html { render :new }
                format.json { render json: @cart.errors,
                    status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /uploads/1
    # PATCH/PUT /uploads/1.json
    def update
        @cart = @upload.cart

        if image = upload_params[:image]
            @cart.photos.build(user: current_user, image: image)
        end

        respond_to do |format|
            if @cart.update(upload_params[:cart_attributes])
                format.html {
                    redirect_to uploads_path,
                    notice: 'Cart was successfully updated.'
                }
                format.json { render :show, status: :ok, location: @upload }
            else
                format.html { render :edit }
                format.json {
                    render json: @cart.errors,
                    status: :unprocessable_entity
                }
            end
        end
    end

    # DELETE /uploads/1
    # DELETE /uploads/1.json
    def destroy
        respond_to do |format|
            if current_user == @upload.user or current_user.has_role? :admin
                @upload.destroy

                format.html {
                    redirect_to uploads_url,
                    notice: 'Cart was successfully destroyed.'
                }
                format.json { head :no_content }
            else
                format.html {
                    redirect_to uploads_url,
                    notice: 'You do not have permission to perform this action.'
                }
                format.json { head :no_content }
            end
        end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_upload
        @upload = Upload.find(params[:id])
    end

    def upload_params
        params.require(:upload).permit(
            :image, cart_attributes: [:name, :permit_number, :lat, :lon],
        )
    end

    private :set_upload
    private :upload_params
end
