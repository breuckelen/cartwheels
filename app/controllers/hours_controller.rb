class HoursController < ApplicationController
    include Fetchable

    def index
        @hours = Hour.all
    end

    def show
    end

    def new
        @hour = Hour.new
    end

    def edit
    end

    def create
        @hour = Hour.new(hour_params)
        @hour.cart_id = params[:cart_id]

        respond_to do |format|
            if @hour.save
                format.html { redirect_to @hour,
                    notice: 'Hour was successfully created.' }
                format.json { render :show, status: :created, location: @hour,
                    json: {success: true}}
                format.js { render locals: {cart: @hour.cart}}
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    json: {success: false, errors: @hour.errors}}
                format.js { render status: :unprocessable_entity,
                    json: {success: false, errors: @hour.errors}}
                format.js { render locals: {cart: @hour.cart}}
            end
        end
    end

    def update
        respond_to do |format|
            if @hour.update(hour_params)
                format.html { redirect_to @hour, notice:
                    'Hour was successfully updated.' }
                format.json { render :show, status: :ok, location: @hour,
                    json: {success: true}}
                format.js { render :show, status: :ok, location: @hour,
                    json: {success: true}}
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    json: {success: false, errors: @hour.errors}}
                format.js { render status: :unprocessable_entity,
                    json: {success: false, errors: @hour.errors}}
            end
        end
    end

    def destroy
        cart = @hour.cart

        respond_to do |format|
            if (current_owner and @hour.cart.in? current_owner.carts) or\
                    (current_user and current_user.has_role? :admin)
                @hour.destroy
                format.html { redirect_to cart,
                    notice: 'Hour was successfully destroyed.' }
                format.json { head :no_content }
            else
                format.html { redirect_to cart,
                    notice: 'You do not have permission to perform this action.'
                }
                format.json { render json: { success: false } }
            end
        end
    end

    def data_params
        params.require(:review).permit(:id, :cart_id)
    end

    def search_params
        ps = params.permit(:offset, :limit, :lq, :tq)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def hour_params
        params.require(:hour).permit(:day, :start, :end)
    end

    private :data_params
    private :search_params
    private :hour_params
end
