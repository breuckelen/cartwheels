class ReviewController < ApplicationController
    def show
        @review = Review.find(params[:id])
    end
end
