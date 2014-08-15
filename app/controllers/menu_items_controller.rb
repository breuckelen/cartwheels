class MenuItemsController < ApplicationController
    include Fetchable
    include Imageable

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
        user = current_user
        user ||= current_owner

        cart = Cart.find(params[:id])
        @menu_item = cart.menu.menu_items.build(menu_item_params)

        if @photo
            @menu_item.photo = @photo
        end

        if request.xhr? || remotipart_submitted?
            if @menu_item.save
                render "shared/concerns/form_multiple",
                    locals: {cart: @menu_item.menu.cart, errors: nil,
                        model: "menu_item"},
                    status: :created
            else
                render "shared/concerns/form_multiple",
                    locals: {cart: @menu_item.menu.cart,
                        errors: @menu_item.errors, model: "menu_item"},
                    status: :unprocessable_entity
            end
        else
            respond_to do |format|
                if @menu_item.save
                    format.json { render status: :created,
                        location: @menu_item,
                        json: { success: true }}
                    format.js { render "shared/concerns/form_multiple",
                            locals: {cart: @menu_item.menu.cart, errors: nil,
                                model: "menu_item"},
                            status: :created
                    }
                else
                    format.json { render json: @menu_item.errors,
                        status: :unprocessable_entity,
                        json: { success: true }}
                    format.js { render "shared/concerns/form_multiple",
                            locals: {cart: @menu_item.menu.cart,
                                errors: @menu_item.errors, model: "menu_item"},
                            status: :unprocessable_entity
                    }
                end
            end
        end
    end

    def update
        if @photo
            @menu_item.photo = @photo
        end

        cart = @menu_item.menu.cart

        respond_to do |format|
            if @menu_item.update(menu_item_params)
                format.html { redirect_to cart,
                    notice: 'Menu item was succesfully updated.' }
                format.json { render :show, status: :ok,
                    location: @menu_item,
                    json: { success: true }}
            else
                format.html { render :edit }
                format.json { render json: @menu_item.errors,
                    status: :unprocessable_entity,
                    json: { success: true }}
            end
        end
    end

    def destroy
        cart = @menu_item.menu.cart

        respond_to do |format|
            if (current_owner and cart.in? current_owner.carts) or\
                    (current_user and current_user.has_role? :admin)
                @menu_item.destroy

                format.html { redirect_to cart,
                    notice: 'Menu item was successfully destroyed.' }
                format.json { render json: { success: true } }
            else
                format.html { redirect_to cart,
                    notice: 'You do not have permission to perform this action.'
                }
                format.json { render json: { success: false } }
            end
        end
    end

    respond_to :json
    def data
        if params[:menu_item].nil? or params[:menu_item].empty?
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
        params.require(:menu_item).permit(:id, :price, :cart_id, :name)
    end

    def search_params
        ps = params.permit(:offset, :limit, :tq, :lq)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def menu_item_params
        params.require(:menu_item).permit(:description, :price, :name)
    end

    private :data_params
    private :search_params
    private :menu_item_params
end
