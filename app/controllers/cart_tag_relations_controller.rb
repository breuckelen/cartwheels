class CartTagRelationsController < ApplicationController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_action :set_ctr, only: [:show, :destroy]

    def index
    end

    # show a review
    def show
    end

    # form for creating a new review for a cart
    def new
        @ctr = CartTagRelation.new
    end

    # create a new review for a cart
    def create
        @ctr = CartTagRelation.new(ctr_params)
        @ctr.cart_id = params[:cart_id]

        respond_to do |format|
            if @ctr.save
                format.html { redirect_to @ctr.cart,
                    notice: 'You successfully added a tag to this cart.' }
                format.json { render :show, status: :created,
                    location: @ctr,
                    :json => { :success => true }}
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    :json => { :success => false, :errors => @ctr.errors}}
            end
        end
    end

    def destroy
        cart = @ctr.cart

        respond_to do |format|
            if current_user.has_role? :admin
                @ctr.destroy

                format.html { redirect_to cart,
                    notice: 'You removed a tag from this cart.' }
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
        @ctrs = CartTagRelation.where(data_params)
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)

        render :status => 200,
            :json => { :success => true, :data => @ctrs }
    end

    def data_params
        params.require(:cart_tag_relation).permit(:id, :cart_id, :tag_id)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def ctr_params
        params.require(:cart_tag_relation).permit(:tag_id)
    end

    def set_ctr
        @ctr = CartTagRelation.find(params[:id])
    end

    private :data_params
    private :search_params
    private :ctr_params
    private :set_ctr
end
