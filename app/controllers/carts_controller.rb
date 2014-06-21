class CartsController < ApplicationController
    # show cart owners
    def index
        # html:
        # map display with interactive popups
        # statistics about cart owners
    end

    # form for creating a new cart
    def new
        # redirect unless cart owner
        # html:
        # validation process for owning a cart
        #   - permit number or other information from DOHMH
        # required fields
    end

    # create a new cart
    def create
        # redirect unless cart owner
    end

    def show
        @cart = Cart.find(data_params[:id])
        # html:
        # show page statistics if owner, manager, or admin
        # allow deletion of reviews if manager or admin
        # show menu ghosts for this cart
    end

    def edit
        # redirect unless cart owner
    end

    def update
        # redirect unless cart owner
    end

    def destroy
        # redirect unless cart owner
    end

    respond_to :json
    def data
        @carts = Cart.where(data_params)
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)

        render :status => 200,
            :json => {
                :success => true,
                :data => @carts
            }
    end

    def search
        @carts = Cart.search(search_params["tq"], search_params["lq"])
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)

        render :status => 200,
            :json => {
                :success => true,
                :data => @carts
            }
    end

    def data_params
        params.require(:cart).permit(:id, :name, :city, :permit_number, :zip_code)
    end

    def search_params
        ps = params.permit(:offset, :limit, :tq, :lq)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    private :data_params
    private :search_params
end
