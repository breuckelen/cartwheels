class UserCartRelationsController < ApplicationController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_action :set_ucr, only: [:show, :destroy]

    def index
    end

    # show a review
    def show
    end

    # form for creating a new review for a cart
    def new
        @ucr = UserCartRelation.new
    end

    # create a new review for a cart
    def create
        @ucr = current_user.user_cart_relations.build(relation_type: 1)
        @ucr.cart_id = params[:cart_id]

        respond_to do |format|
            if @ucr.save
                format.html { redirect_to @ucr.cart,
                    notice: 'You successfully subscribed to this cart.' }
                format.json { render :show, status: :created,
                    location: @ucr,
                    :json => { :success => true }}
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    :json => { :success => false, :errors => @ucr.errors}}
            end
        end
    end

    def destroy
        cart = @ucr.cart

        respond_to do |format|
            if current_user == @ucr.user or current_user.has_role? :admin
                @ucr.destroy

                format.html { redirect_to cart,
                    notice: 'You successfully unsubscribed from this cart.' }
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
        if params[:user_cart_relation].empty?
            @ucrs = UserCartRelation.limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        else
            @ucrs = UserCartRelation.where(data_params)
                .limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        end

        render :status => 200,
            :json => { :success => true, :data => @ucrs }
    end

    def data_params
        params.require(:user_cart_relation).permit(:id, :user_id, :cart_id)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def set_ucr
        @ucr = UserCartRelation.find(params[:id])
    end

    private :data_params
    private :search_params
    private :set_ucr
end
