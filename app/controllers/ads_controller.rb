class AdsController < ApplicationController
    include Fetchable

    def index
    end

    def show
    end

    def new
        if current_user.has_role? :admin
            @ad = Ad.new
        else
            return redirect_to home_path,
                notice: "You do not have access to this page."
        end
    end

    def edit
    end

    def create
        @ad = Cart.find_by_id(params[:cart_id]).ads.new(ad_params)

        respond_to do |format|
            if @ad.save
                format.html { redirect_to @ad,
                    notice: 'Ad was succesfully created.' }
                format.json { render :show, status: :created,
                    location: @ad,
                    json: { success: true }}
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    json: { success: false, errors: @ad.errors}}
            end
        end
    end

    def update
        respond_to do |format|
            if @ad.update(ad_params)
                format.html { redirect_to @ad,
                    notice: 'Ad was succesfully updated.' }
                format.json { render :show, status: :ok,
                    location: @ad,
                    json: { success: true }}
            else
                format.html { render :edit }
                format.json { render status: :unprocessable_entity,
                    json: { success: false, errors: @ad.errors } }
            end
        end
    end

    def destroy
        cart = @ad.cart

        respond_to do |format|
            if current_user.has_role? :admin
                @ad.destroy

                format.html { redirect_to cart,
                    notice: 'Ad was successfully destroyed.' }
                format.json { render json: {
                    success: true } }
            else
                format.html { redirect_to cart,
                    notice: 'You do not have permission to perform this action.' }
                format.json { render json: { success: false } }
            end
        end
    end

    def search
    end

    def data_params
        params.require(:ad).permit(:id, :cart_id, :ad_type_id)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def ad_params
        params.require(:ad).permit(:ad_type_id, :title, :description)
    end

    private :data_params
    private :search_params
    private :ad_params
end
