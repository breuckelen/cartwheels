class CartsController < ApplicationController
    skip_before_filter :authenticate_basic_http, only: [:data]

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
        @cart = Cart.find(params[:id])
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
        @carts = Cart.all
        render :status => 200,
            :json => { :success => true,
                :data => @carts }
    end
end
