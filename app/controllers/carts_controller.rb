class CartsController < ApplicationController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_filter :authenticate_user!, only: [:new]
    before_action :set_cart, only: [:show, :edit, :update, :destroy, :claim]

    # show cart owners
    def index
        # html:
        # map display with interactive popups
        # statistics about cart owners
        @carts = Cart.where(created_at: (Time.now - 1.day)..Time.now)
    end

    def show
        # html:
        # show page statistics if owner, manager, or admin
        # allow deletion of reviews if manager or admin
        # show menu ghosts for this cart
    end

    # form for creating a new cart
    def new
        # redirect unless cart owner
        # html:
        # validation process for owning a cart
        #   - permit number or other information from DOHMH
        # required fields
        @cart = Cart.new
    end

    def edit
    end

    # create a new cart
    def create
        # redirect unless cart owner
        @cart = Cart.new(cart_params)
        @cart.user_cart_relations.build(user: current_user, relation_type: 0)

        if image = params[:cart][:image]
            @cart.photos.build(user: current_user, image: image)
        end

        if request.xhr? || remotipart_submitted?
            if @cart.save
                flash[:notice] = "Cart was successfully created."
                render locals: {errors: nil, redirect_path: cart_path(@cart)},
                    status: :created
            else
                render locals: {errors: @cart.errors}, status: :unprocessable_entity
            end
        else
            respond_to do |format|
                if @cart.save
                    flash[:notice] = "Cart was successfully created."
                    format.json { render status: :created,
                        location: carts_path,
                        :json => { :success => true }}
                else
                    format.json { render status: :unprocessable_entity,
                        :json => { :errors => @cart.errors, :success => false }}
                end
            end
        end
    end

    def update
        if image = params[:cart][:image]
            @cart.photos.build(user: current_user, image: image)
        end

        respond_to do |format|
            if (current_user and (current_user == @cart.uploader or current_user.has_role? :admin))\
                    or (current_owner.in? @cart.owners)
                Cart.skip_callback(:validation, :before, :update_popularity)
                Cart.skip_callback(:validation, :before, :update_rating)
                Cart.skip_callback(:validation, :before, :update_location)

                if @cart.update(cart_params)
                    Cart.set_callback(:validation, :before, :update_popularity)
                    Cart.set_callback(:validation, :before, :update_rating)
                    Cart.set_callback(:validation, :before, :update_location)

                    format.html { redirect_to carts_path,
                        notice: 'Cart was succesfully updated.' }
                    format.json { render :show, status: :ok,
                        location: @cart,
                        :json => { :success => true }}
                else
                    Cart.set_callback(:validation, :before, :update_popularity)
                    Cart.set_callback(:validation, :before, :update_rating)
                    Cart.set_callback(:validation, :before, :update_location)

                    format.html { render :edit }
                    format.json { render status: :unprocessable_entity,
                        :json => { :errors => @cart.errors, :success => false }}
                end
            else
                format.html { redirect_to @cart,
                    notice: 'You do not have permission to perform this action.' }
                format.json { render json: {
                    success: false }
                }
            end
        end
    end

    def destroy
        respond_to do |format|
            if current_user == @cart.uploader or current_user.has_role? :admin
                @cart.destroy

                format.html { redirect_to carts_path,
                    notice: 'Cart was successfully destroyed.' }
                format.json { render json: {
                    success: true } }
            else
                format.html { redirect_to @cart,
                    notice: 'You do not have permission to perform this action.' }
                format.json { render json: {
                    success: false }
                }
            end
        end
    end

    respond_to :json
    def data
        if params[:cart].empty?
            @carts = Cart.limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        else
            @carts = Cart.where(data_params)
                .limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        end

        render :status => 200, :json => { :success => true,
            :data => @carts }
    end

    def search
        @carts = Cart.search(search_params["sort_by"], search_params["tq"],
                search_params["lq"])
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)

        render :status => 200, :json => { :success => true,
            :data => @carts }
    end

    def claim
        respond_to do |format|
            if params[:permit_number].to_i == @cart.permit_number
                @cart.owners << current_owner

                format.html { redirect_to carts_path,
                    notice: 'Cart successfully claimed.' }
                format.json { render json: {
                    success: true } }
            else
                format.html { redirect_to @cart,
                    notice: 'You do not have permission to perform this action.' }
                format.json { render json: {
                    success: false }
                }
            end
        end
    end

    def data_params
        params.require(:cart).permit(:id, :name, :city, :permit_number, :zip_code)
    end

    def search_params
        ps = params.permit(:offset, :limit, :sort_by, :tq, :lq)
        defaults = {"offset" => 0, "limit" => 20, "sort_by" => "popularity"}
        defaults.merge(ps)
    end

    def cart_params
        params.require(:cart).permit(:name, :city, :permit_number, :lat, :lon,
            :green, :rating, :description)
    end

    def set_cart
        @cart = Cart.find(params[:id])
    end

    private :data_params
    private :search_params
    private :cart_params
    private :set_cart
end
