class MenuItemsController < ApplicationController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_action :set_menu_item, only: [:show, :edit, :update, :destroy]

    def index
        @menu_items = MenuItem.all
    end

    def show
    end

    def new
        @menu_item = MenuItem.new
    end

    def edit
    end

    def create
        @menu_item = MenuItem.new(menu_item_params)
        cart = Cart.find_by_id(params[:id])
        @menu_item.menu = cart.menu

        if image = params[:menu_item][:image]
            @menu_item.photos.build(user: current_user, image: image)
        end

        respond_to do |format|
            if @menu_item.save
                format.html { redirect_to cart,
                    notice: 'Menu item was succesfully created.' }
                format.json { render :show, status: :created,
                    location: @menu_item,
                    :json => { :success => true }}
            else
                format.html { render :new }
                format.json { render json: @menu_item.errors,
                    status: :unprocessable_entity,
                    :json => { :success => false }}
            end
        end
    end

    def update
        if image = params[:menu_item][:image]
            @menu_item.photos.build(user: current_user, image: image)
        end

        cart = @menu_item.menu.cart

        respond_to do |format|
            if @menu_item.update(menu_item_params)
                format.html { redirect_to cart,
                    notice: 'Menu item was succesfully updated.' }
                format.json { render :show, status: :ok,
                    location: @menu_item,
                    :json => { :success => true }}
            else
                format.html { render :edit }
                format.json { render json: @menu_item.errors,
                    status: :unprocessable_entity,
                    :json => { :success => false }}
            end
        end
    end

    def destroy
        cart = @menu_item.menu.cart
        respond_to do |format|
            if current_user.has_role? :admin
                @menu_item.destroy

                format.html { redirect_to cart,
                    notice: 'Menu item was successfully destroyed.' }
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
        if params[:menu_item].empty?
            @menu_items = MenuItem.limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        else
            new_params = data_params

            if new_params[:cart_id]
                cart = Cart.find_by_id(new_params.delete(:cart_id))

                if cart
                    new_params[:menu_id] = cart.menu.id
                else
                    new_params[:menu_id] = -1
                end
            end

            @menu_items = MenuItem.where(new_params)
                .limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)

        end

        render :status => 200, :json => { :success => true,
            :data => @menu_items }
    end

    def search
    end

    def data_params
        params.require(:menu_item).permit(:id, :price, :cart_id)
    end

    def search_params
        ps = params.permit(:offset, :limit, :tq, :lq)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def menu_item_params
        params.require(:menu_item).permit(:description, :price)
    end

    def set_menu_item
        @menu_item = MenuItem.find(params[:id])
    end

    private :data_params
    private :search_params
    private :menu_item_params
    private :set_menu_item
end
