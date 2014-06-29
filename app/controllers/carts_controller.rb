class CartsController < ApplicationController
    before_action :set_cart, only: [:show, :edit, :update, :destroy]

    # show cart owners
    def index
        # html:
        # map display with interactive popups
        # statistics about cart owners
        @carts = Cart.where(updated_at: (Time.now - 1.day)..Time.now)
    end

    def show
        # html:
        # show page statistics if owner, manager, or admin
        # allow deletion of reviews if manager or admin
        # show menu ghosts for this cart
    end

    # form for creating a new cart
    def new
        # redirect unless cart owner
        # html:
        # validation process for owning a cart
        #   - permit number or other information from DOHMH
        # required fields
        @cart = Cart.new
    end

    def edit
    end

    # create a new cart
    def create
        # redirect unless cart owner
        @cart = Cart.new(cart_params)
        @cart.user_cart_relations.build(user: current_user, relation_type: 0)

        if image = params[:cart][:image]
            @cart.photos.build(user: current_user, image: image)
        end

        respond_to do |format|
            if @cart.save
                format.html { redirect_to carts_path,
                    notice: 'Cart was succesfully created.' }
                format.json { render :show, status: :created,
                    location: @cart }
            else
                format.html { render :new }
                format.json { render json: @cart.errors,
                    status: :unprocessable_entity }
            end
        end
    end

    def update
        if image = params[:cart][:image]
            @cart.photos.build(user: current_user, image: image)
        end

        respond_to do |format|
            if @cart.save
                format.html { redirect_to carts_path,
                    notice: 'Cart was succesfully created.' }
                format.json { render :show, status: :created,
                    location: @cart }
            else
                format.html { render :new }
                format.json { render json: @cart.errors,
                    status: :unprocessable_entity }
            end
        end
    end

    def destroy
        respond_to do |format|
            if current_user == @cart.uploader or current_user.has_role? :admin
                @cart.destroy

                format.html { redirect_to carts_path,
                    notice: 'Cart was successfully destroyed.' }
                format.json { render json: {
                    success: true } }
            else
                format.html { redirect_to carts_path,
                    notice: 'You do not have permission to perform this action.' }
                format.json { render json: {
                    success: false }
                }
            end
        end
    end

    respond_to :json
    def data
        @carts = Cart.where(data_params)
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)

        render :status => 200, :json => { :success => true,
            :data => @carts }
    end

    def search
        @carts = Cart.search(search_params["tq"], search_params["lq"])
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)

        render :status => 200, :json => { :success => true,
            :data => @carts }
    end

    def data_params
        params.require(:cart).permit(:id, :name, :city, :permit_number, :zip_code)
    end

    def search_params
        ps = params.permit(:offset, :limit, :tq, :lq)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def cart_params
        params.require(:cart).permit(:name, :name, :permit_number, :lat, :lon)
    end

    def set_cart
        @cart = Cart.find(params[:id])
    end

    private :set_cart
    private :data_params
    private :search_params
    private :cart_params
end
