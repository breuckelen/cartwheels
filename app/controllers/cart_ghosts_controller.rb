class CartGhostsController < ApplicationController
    # show all cart ghosts
    def index
        # html:
        # searching on cart ghosts
    end

    # form for creating new cart ghosts
    def new
        # html:
        # require essential fields
    end

    # create a cart ghost
    def create
    end

    # show a cart ghost
    def show
        # html:
        # allow upvotes for users
        # allow updating, approval, deletion for admins and managers
    end

    # edit a cart ghost
    def edit
        # redirect unless admin or manager
    end

    # update a cart ghost
    def update
        # redirect unless admin or manager
    end

    # destroy a cart ghost
    def destroy
        # redirect unless admin or manager
    end

    respond_to :json
    def data
        @carts = CartGhost.where(data_params)
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)

        render :status => 200,
            :json => {
                :success => true,
                :data => @carts
            }
    end

    def search
        @carts = CartGhost.search(search_params["tq"], search_params["lq"])
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
