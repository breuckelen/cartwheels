class CartCategoryRelationsController < ApplicationController
    include Fetchable

    def index
    end

    def show
    end

    def new
        @cart_category_relation = CartCategoryRelation.new
    end

    def create
        respond_to do |format|
            if Category.find(ccr_params[:category_id])
                @cart_category_relation = CartCategoryRelation.new(ccr_params)
                @cart_category_relation.cart_id = params[:cart_id]

                if @cart_category_relation.save
                    format.html { redirect_to @cart_category_relation.cart,
                        notice: 'You successfully added a category to this cart.'
                    }
                    format.json { render status: :created,
                        location: last_path(current_user),
                        json: { success: true }}
                    format.js { render "shared/concerns/form_modal",
                        locals: {cart: @cart_category_relation.cart, errors: nil,
                            modal: "categories"}}
                else
                    format.html { render :new }
                    format.json { render status: :unprocessable_entity,
                        json: { success: false,
                            errors: @cart_category_relation.errors }}
                    format.js { render "shared/concerns/form_modal",
                        locals: {cart: @cart_category_relation.cart,
                            errors: @cart_category_relation.errors,
                            modal: "categories"}}
                end
            else
                cart = Cart.find(params[:cart_id])
                errors = { category_id: "This category does not exist."}
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    json: { success: false, errors: errors}}
                format.js { render "shared/concerns/form_modal",
                    locals: {cart: cart, errors: errors, modal: "categories"}}

            end
        end
    end

    def destroy
        cart = @cart_category_relation.cart

        respond_to do |format|
            if (current_owner and cart.in? current_owner.carts) or\
                    (current_user and current_user.has_role? :admin)
                @cart_category_relation.destroy

                format.html { redirect_to cart,
                    notice: 'You removed a category from this cart.' }
                format.json { render json: {
                    success: true } }
            else
                format.html { redirect_to cart,
                    notice: 'You do not have permission to perform this action.'
                }
                format.json { render json: { success: false } }
            end
        end
    end

    def data_params
        params.require(:cart_category_relation).permit(:id, :cart_id,
            :category_id)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def ccr_params
        params.require(:cart_category_relation).permit(:category_id)
    end

    def set_cart_category_relation
        @cart_category_relation = CartCategoryRelation.find(params[:id])
    end

    private :data_params
    private :search_params
    private :ccr_params
end
