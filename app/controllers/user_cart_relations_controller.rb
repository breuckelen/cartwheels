class UserCartRelationsController < ApplicationController
    include Fetchable

    def index
    end

    def show
    end

    def new
        @user_cart_relation = UserCartRelation.new
    end

    def create
        @user_cart_relation = current_user.user_cart_relations.build(
            relation_type: 1)
        @user_cart_relation.cart_id = params[:cart_id]

        respond_to do |format|
            if @user_cart_relation.save
                format.html { redirect_to @user_cart_relation.cart,
                    notice: 'You successfully subscribed to this cart.' }
                format.json { render :show, status: :created,
                    location: @user_cart_relation,
                    json: { success: true }}
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    json: { success: false, errors: @user_cart_relation.errors}}
            end
        end
    end

    def destroy
        cart = @user_cart_relation.cart

        respond_to do |format|
            if current_user == @user_cart_relation.user or current_user.has_role? :admin
                @user_cart_relation.destroy

                format.html { redirect_to cart,
                    notice: 'You successfully unsubscribed from this cart.' }
                format.json { render json: { success: true } }
            else
                format.html { redirect_to cart,
                    notice: 'You do not have permission to perform this action.'
                }
                format.json { render json: { success: false } }
            end
        end
    end

    def data_params
        params.require(:user_cart_relation).permit(:id, :user_id, :cart_id)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    private :data_params
    private :search_params
end
