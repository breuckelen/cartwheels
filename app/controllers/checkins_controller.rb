class CheckinsController < ApplicationController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_action :set_checkin, only: [:show, :edit, :update, :destroy]
    before_action :set_cart, only: [:new]

    def index
    end

    # show a checkin
    def show
    end

    # form for creating a new checkin for a cart
    def new
        @checkin = Checkin.new
    end

    def edit
    end

    # create a new checkin for a cart
    def create
        if current_user != nil
            @checkin = current_user.checkins.build(checkin_params)
        elsif current_owner != nil
            @checkin = current_owner.checkins.build(checkin_params)
        end

        @checkin.cart_id = params[:cart_id]

        if image = params[:checkin][:image]
            @checkin.photos.build(user: current_user, image: image)
        end

        respond_to do |format|
            if @checkin.save
                @checkin.cart.photos.create(user: current_user, image: image)

                format.json { render status: :created,
                    location: last_path(current_user),
                    :json => { :success => true }}
                format.js { render status: :created,
                    location: last_path(current_user),
                    :json => { :success => true }}
            else
                format.json { render status: :unprocessable_entity,
                    :json => { :success => false, :errors => @checkin.errors}}
                format.js { render status: :unprocessable_entity,
                    :json => { :success => false, :errors => @checkin.errors}}
            end
        end
    end

    def update
        if image = params[:checkin][:image]
            @checkin.photos.build(user: current_user, image: image)
        end

        respond_to do |format|
            if @checkin.update(checkin_params)
                format.html { redirect_to last_path(current_user),
                    notice: 'Checkin was succesfully updated.' }
                format.json { render status: :ok,
                    location: last_path(current_user),
                    :json => { :success => true }}
            else
                format.html { render :edit }
                format.json { render status: :unprocessable_entity,
                    :json => { :success => false, :errors => @checkin.errors}}
            end
        end
    end

    def destroy
        cart = @checkin.cart

        respond_to do |format|
            if (current_user == @checkin.user or current_owner == @checkin.user)\
                    or current_user.has_role? :admin
                @checkin.destroy

                format.html { redirect_to cart,
                    notice: 'Checkin was successfully destroyed.' }
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
        if params[:checkin].empty?
            @checkins = Checkin.limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        else
            @checkins = Checkin.where(data_params)
                .limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        end

        render :status => 200,
            :json => { :success => true, :data => @checkins }
    end

    def search
        @checkins = Checkin.search(search_params["tq"], search_params["lq"])
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)

        render :status => 200, :json => { :success => true,
            :data => @checkins }
    end

    def data_params
        params.require(:checkin).permit(:id, :user_id, :user_type, :cart_id)
    end

    def search_params
        ps = params.permit(:offset, :limit, :tq, :lq)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def checkin_params
        params.require(:checkin).permit(:lat, :lon, :description)
    end

    def set_checkin
        @checkin = Checkin.find(params[:id])
    end

    def set_cart
        @cart = Cart.find(params[:cart_id])
    end

    private :data_params
    private :search_params
    private :checkin_params
    private :set_checkin
    private :set_cart
end
