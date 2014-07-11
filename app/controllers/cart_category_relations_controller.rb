class CartCategoryRelationsController < ApplicationController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_action :set_ccr, only: [:show, :destroy]

    def index
    end

    # show a review
    def show
    end

    # form for creating a new review for a cart
    def new
        @ccr = CartCategoryRelation.new
    end

    # create a new review for a cart
    def create
        respond_to do |format|
            if Category.find(ccr_params[:category_id])
                @ccr = CartCategoryRelation.new(ccr_params)
                @ccr.cart_id = params[:cart_id]

                if @ccr.save
                    format.html { redirect_to @ccr.cart,
                        notice: 'You successfully added a category to this cart.' }
                    format.json { render status: :created,
                        location: last_path(current_user),
                        :json => { :success => true }}
                    format.js { render locals: {cart: @ccr.cart, errors: nil}}
                else
                    format.html { render :new }
                    format.json { render status: :unprocessable_entity,
                        :json => { :success => false, :errors => @ccr.errors }}
                    format.js { render locals: {cart: @ccr.cart,
                        errors: @ccr.errors }}
                end
            else
                cart = Cart.find(params[:cart_id])
                errors = { category_id: "This category does not exist."}
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    :json => { :success => false, errors: errors}}
                format.js { render locals: {cart: cart,
                    errors: errors }}

            end
        end
    end

    def destroy
        cart = @ccr.cart

        respond_to do |format|
            if current_user.has_role? :admin
                @ccr.destroy

                format.html { redirect_to cart,
                    notice: 'You removed a category from this cart.' }
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
        if params[:cart_category_relation].empty?
            @ccrs = CartCategoryRelation.limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        else
            @ccrs = CartCategoryRelation.where(data_params)
                .limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        end

        render :status => 200,
            :json => { :success => true, :data => @ccrs }
    end

    def data_params
        params.require(:cart_category_relation).permit(:id, :cart_id, :category_id)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def ccr_params
        params.require(:cart_category_relation).permit(:category_id)
    end

    def set_ccr
        @ccr = CartCategoryRelation.find(params[:id])
    end

    private :data_params
    private :search_params
    private :ccr_params
    private :set_ccr
end
