class TagsController < ApplicationController
    # show tags belonging to a specific cart
    def index
        # html:
        # show other carts with same tags
    end

    # form for adding new category to cart
    def new
        # redirect unless an owner, manager, or admin
    end

    # create a new category for the cart
    def create
        # redirect unless an owner, manager, or admin
    end

    def edit
    end

    def update
    end

    def destroy
        # redirect unless an owner, manager, or admin
    end

    # update tags remotely
    # ADD A ROUTE
    def tags_data
        # redirect unless an admin or a manager
        # update tags based on query
    end
end
