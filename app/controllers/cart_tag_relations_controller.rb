class CartTagRelationsController < ApplicationController
    include Fetchable

    def index
    end

    def show
    end

    def new
        @cart_tag_relation = CartTagRelation.new
    end

    def create
        respond_to do |format|
            if Tag.find(ctr_params[:tag_id])
                @cart_tag_relation = CartTagRelation.new(ctr_params)
                @cart_tag_relation.cart_id = params[:cart_id]

                if @cart_tag_relation.save
                    format.html { redirect_to @cart_tag_relation.cart,
                        notice: 'You successfully added a tag to this cart.'
                    }
                    format.json { render status: :created,
                        location: last_path(current_user),
                        json: { success: true }}
                    format.js { render "shared/concerns/form_modal",
                        locals: {cart: @cart_tag_relation.cart, errors: nil,
                            modal: "tags"}}
                else
                    format.html { render :new }
                    format.json { render status: :unprocessable_entity,
                        json: { success: false,
                            errors: @cart_tag_relation.errors }}
                    format.js { render "shared/concerns/form_modal",
                        locals: {cart: @cart_tag_relation.cart,
                            errors: @cart_tag_relation.errors,
                            modal: "tags"}}
                end
            else
                cart = Cart.find(params[:cart_id])
                errors = { tag_id: "This tag does not exist."}
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    json: { success: false, errors: errors}}
                format.js { render "shared/concerns/form_modal",
                    locals: {cart: cart, errors: errors, modal: "tags"}}

            end
        end
    end

    def destroy
        cart = @cart_tag_relation.cart

        respond_to do |format|
            if (current_owner and cart.in? current_owner.carts) or\
                    (current_user and current_user.has_role? :admin)
                @cart_tag_relation.destroy

                format.html { redirect_to cart,
                    notice: 'You removed a tag from this cart.' }
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
        params.require(:cart_tag_relation).permit(:id, :cart_id,
            :tag_id)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def ctr_params
        params.require(:cart_tag_relation).permit(:tag_id)
    end

    def set_cart_tag_relation
        @cart_tag_relation = CartTagRelation.find(params[:id])
    end

    private :data_params
    private :search_params
    private :ctr_params
end
