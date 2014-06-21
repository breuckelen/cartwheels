class ReviewsController < ApplicationController
    # form for creating a new review for a cart
    def new
    end

    # create a new review for a cart
    def create
    end

    # show a review
    def show
        @review = Review.find(params[:id])
    end

    def edit
    end

    def update
    end

    def destroy
    end

    respond_to :json
    def data
        @reviews = Review.where(data_params)
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)

        render :status => 200,
            :json => {
                :success => true,
                :data => @reviews
            }
    end

    def search
    end

    def data_params
        params.require(:review).permit(:user_id, :cart_id)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    private :data_params
    private :search_params
end
