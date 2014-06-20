class CartGhostsController < ApplicationController
    # show all cart ghosts
    def index
        # html:
        # searching on cart ghosts
    end

    # form for creating new cart ghosts
    def new
        # html:
        # require essential fields
    end

    # create a cart ghost
    def create
    end

    # show a cart ghost
    def show
        # html:
        # allow upvotes for users
        # allow updating, approval, deletion for admins and managers
    end

    # edit a cart ghost
    def edit
        # redirect unless admin or manager
    end

    # update a cart ghost
    def update
        # redirect unless admin or manager
    end

    # destroy a cart ghost
    def destroy
        # redirect unless admin or manager
    end

    # update carts ghosts remotely
    # ADD A ROUTE
    def data
        # update cart ghosts based on query
    end
end
