class AdsController < ApplicationController
    # ads belonging to a cart
    def index
        # redirect unless the owner owns the cart
        # html:
        # allow the owner to delete ads / purchase them
    end

    def new
        # redirect to purchase
    end

    # purchase a new ad by entering payment information
    # ADD ROUTE
    def purchase
        # redirect unless the owner owns the cart
        # html:
        # use stripe to facilitate payment
    end

    # create a new ad
    def create
        # redirect unless the owner owns the cart
    end

    def show
        # redirect unless the owner owns the cart
        # html:
        # allow the owner to edit the ad
    end

    # edit the ad
    def edit
        # redirect unless the owner owns the cart
    end

    # update the ad
    def update
        # redirect unless the owner owns the cart
    end

    # destroy the ad
    def destroy
        # redirect unless the owner owns the cart
    end
end
