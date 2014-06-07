class UploadsController < ApplicationController
    before_action :set_upload, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_user!

    # GET /uploads
    # GET /uploads.json
    def index
        @uploads = Upload.all
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

        respond_to do |format|
            if @upload.save
                format.html { redirect_to @upload, notice: 'Cart was succesfully created.' }
                format.json { render :show, status: :created, location: @upload }
            else
                format.html { render :new }
                format.json { render json: @cart.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /uploads/1
    # PATCH/PUT /uploads/1.json
    def update
        @cart = @upload.cart

        respond_to do |format|
            if @cart.update(upload_params[:cart_attributes])
                format.html { redirect_to @upload, notice: 'Cart was successfully updated.' }
                format.json { render :show, status: :ok, location: @upload }
            else
                format.html { render :edit }
                format.json { render json: @cart.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /uploads/1
    # DELETE /uploads/1.json
    def destroy
        @upload.destroy
        respond_to do |format|
            format.html { redirect_to uploads_url, notice: 'Cart was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
        @upload = Upload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
        params.require(:upload).permit(cart_attributes: [:name, :permit_number, :lat, :lon])
    end
end
