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

    # update reviews remotely
    # ADD A ROUTE
    def reviews_data
        # redirect unless an admin or a manager
        # update reviews based on query
    end
end
