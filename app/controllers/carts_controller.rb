class CartsController < ApplicationController
    include Fetchable
    include Imageable

    skip_before_filter :authenticate_user!
    skip_before_filter :authenticate_owner!

    before_filter :authenticate_user!, only: [:new, :create, :update, :destroy,
        :mark_as_moved]
    skip_before_filter :authenticate_user!,
        :if => Proc.new { |c| current_owner != nil }

    before_filter :authenticate_owner!, only: [:new, :edit, :create, :update,
        :destroy, :claim]
    skip_before_filter :authenticate_owner!,
        :if => Proc.new { |c| current_user != nil }

    skip_before_action :set_instance
    before_action :set_instance, only: [:show, :edit, :update, :destroy,
        :claim, :mark_as_moved]

    def index
        @carts = Cart.where(created_at: (Time.now - 1.day)..Time.now)
    end

    def show
    end

    def new
        @cart = Cart.new
    end

    def edit
    end

    def create
        user = current_user
        user ||= current_owner

        @cart = Cart.new(cart_params)

        if @photo
            @cart.photos << @photo
        end

        if user_signed_in?
            @cart.user_cart_relations.build(user: user, relation_type: 0)
        else
            @cart.cart_owner_relations.build(owner: user)
        end

        if request.xhr? || remotipart_submitted?
            if @cart.save
                flash[:notice] = "Cart was successfully created."
                render "shared/concerns/form_default",
                    locals: {errors: nil, redirect_path: cart_path(@cart)},
                    status: :created
            else
                render "shared/concerns/form_default",
                    locals: {errors: @cart.errors},
                    status: :unprocessable_entity
            end
        else
            respond_to do |format|
                if @cart.save
                    flash[:notice] = "Cart was successfully created."
                    format.json { render status: :created,
                        location: carts_path,
                        :json => { :success => true }}
                    format.js { render "shared/concerns/form_default",
                        locals: {errors: nil,
                        redirect_path: last_path(current_owner)}}
                else
                    format.json { render status: :unprocessable_entity,
                        :json => { :errors => @cart.errors, :success => false }}
                    format.js {render "shared/concerns/form_default",
                        locals: {errors: @cart.errors}}
                end
            end
        end
    end

    def update
        if current_owner.in? @cart.owners or\
                (current_user and current_user.has_role? :admin)

            user = current_user
            user ||= current_owner

            if @photo
                @cart.photos << @photo
            end

            @cart.moved = false

            if request.xhr? || remotipart_submitted?
                Cart.skip_updates

                if @cart.update(cart_params)
                    Cart.set_updates

                    flash[:notice] = "Cart was successfully updated."
                    render "shared/concerns/form_default",
                        locals: {errors: nil, redirect_path: cart_path(@cart)},
                        status: :created
                else
                    Cart.set_updates

                    render "shared/concerns/form_default",
                        locals: {errors: @cart.errors},
                        status: :unprocessable_entity
                end
            else
                respond_to do |format|
                    Cart.skip_updates

                    if @cart.update(cart_params)
                        Cart.set_updates

                        format.html { redirect_to carts_path,
                            notice: 'Cart was succesfully updated.' }
                        format.json { render :show, status: :ok,
                            location: @cart,
                            :json => { :success => true }}
                        format.js { render "shared/concerns/form_default",
                            locals: {errors: nil,
                            redirect_path: last_path(current_owner)}}
                    else
                        Cart.set_updates

                        format.html { render :edit }
                        format.json { render status: :unprocessable_entity,
                            json: { :errors => @cart.errors,
                                :success => false }}
                        format.js {render "shared/concerns/form_default",
                            locals: {errors: @cart.errors}}
                    end
                end
            end
        else
            respond_to do |format|
                format.html { redirect_to @cart,
                    notice: 'You do not have permission to perform this action.'
                }
                format.json { render json: { success: false } }
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
                    notice: 'You do not have permission to perform this action.'
                }
                format.json { render json: { success: false } }
            end
        end
    end

    def search
        @carts = Cart.search(search_params["sort_by"], search_params["tq"],
                search_params["lq"], search_params["categories"],
                search_params["box"])
            .limit(search_params["limit"])
            .offset(search_params["offset"])

        render :status => 200, :json => { :success => true, :data => @carts }
    end

    def claim
        respond_to do |format|
            if not @cart.permit_number.empty? and\
                    params[:permit_number] == @cart.permit_number
                @cart.owners << current_owner

                format.html { redirect_to @cart,
                    notice: 'Cart successfully claimed.' }
                format.json { render json: { success: true } }
            else
                format.html { redirect_to last_path(current_owner),
                    notice: 'You do not have permission to perform this action.'
                }
                format.json { render json: { success: false } }
            end
        end
    end

    def mark_as_moved
        respond_to do |format|
            if @cart.update_attributes(moved: params[:moved])
                format.html { redirect_to @cart,
                    notice: 'Cart marked as moved' }
                format.json { render json: { success: true } }
            else
                format.html { redirect_to @cart, notice: 'Failed to mark cart' }
                format.json { render json: { success: false } }
            end
        end
    end

    def data_params
        params.require(:cart).permit(:id, :name, :city, :permit_number,
            :zip_code)
    end

    def search_params
        ps = params.permit(:offset, :limit, :sort_by, :tq, :lq, categories: [],
            box: [])
        defaults = {"offset" => 0, "limit" => 20, "sort_by" => "popularity",
            "categories" => [], "box" => []}
        defaults.merge(ps)
    end

    def cart_params
        params.require(:cart).permit(:name, :city, :permit_number, :lat, :lon,
            :green, :rating, :description, :twitter_handle)
    end

    private :data_params
    private :search_params
    private :cart_params
end
