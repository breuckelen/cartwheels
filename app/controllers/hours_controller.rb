class HoursController < ApplicationController
    before_action :set_hour, only: [:show, :edit, :update, :destroy]

    # GET /hours
    # GET /hours.json
    def index
        @hours = Hour.all
    end

    # GET /hours/1
    # GET /hours/1.json
    def show
    end

    # GET /hours/new
    def new
        @hour = Hour.new
    end

    # GET /hours/1/edit
    def edit
    end

    # POST /hours
    # POST /hours.json
    def create
        @hour = Hour.new(hour_params)
        @hour.cart_id = params[:cart_id]

        respond_to do |format|
            if @hour.save
                format.html { redirect_to @hour, notice: 'Hour was successfully created.' }
                format.json { render :show, status: :created, location: @hour,
                    json: {success: true}}
                format.js { render locals: {cart: @hour.cart}}
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    json: {success: false, errors: @hour.errors}}
                format.js { render status: :unprocessable_entity,
                    json: {success: false, errors: @hour.errors}}
                format.js { render locals: {cart: @hour.cart }}
            end
        end
    end

    # PATCH/PUT /hours/1
    # PATCH/PUT /hours/1.json
    def update
        respond_to do |format|
            if @hour.update(hour_params)
                format.html { redirect_to @hour, notice: 'Hour was successfully updated.' }
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

    # DELETE /hours/1
    # DELETE /hours/1.json
    def destroy
        respond_to do |format|
            if (current_owner and @hour.cart.in? current_owner.carts) or\
                (current_user and current_user.has_role? :admin)
                @hour.destroy
                format.html { redirect_to home_path, notice: 'Hour was successfully destroyed.' }
                format.json { head :no_content }
            else
                format.html { redirect_to home_path,
                    notice: 'You do not have permission to perform this action.' }
                format.json { render json: { success: false } }
            end
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_hour
        @hour = Hour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hour_params
        params.require(:hour).permit(:day, :start, :end, :cart_id)
    end
end
