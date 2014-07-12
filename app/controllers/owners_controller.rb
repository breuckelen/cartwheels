class OwnersController < ApplicationController
    before_filter :authenticate_owner!, only: [:show, :edit, :update]

    def show
        if current_owner.id == params[:id].to_i
            @owner = current_owner
        else
            return redirect_to home_path,
                notice: "You do not have access to this page."
        end
    end

    def edit
        # redirect unless owner of the cart
    end

    def update
        # redirect unless owner of the cart
    end

    def destroy
        # redirect unless owner of the cart, admin, or manager
    end

    respond_to :json
    def data
        if params[:owner].empty?
            @owners = Owner.limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        else
            @owners = Owner.where(data_params)
                .limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        end

        render :status => 200,
            :json => { :success => true, :data => @owners }
    end

    def data_params
        params.require(:owner).permit(:id, :email, :name)
    end

    def search_params
        ps = params.permit(:offset, :limit, :tq, :lq)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    private :data_params
    private :search_params
end
