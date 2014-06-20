class MenuGhostsController < ApplicationController
    # show all menu ghosts for a specific cart
    def index
        # html:
        # searching on menu ghosts
    end

    # form for creating new menu ghosts for a cart
    def new
        # html:
        # require essential fields
    end

    # create a menu ghost for a cart
    def create
    end

    # show a menu ghost
    def show
        # html:
        # allow upvotes for users
        # allow updating for admins and managers
        # allow approval for admins and managers
    end

    # edit a menu ghost
    def edit
        # redirect unless admin or manager
    end

    # update a menu ghost
    def update
        # redirect unless admin or manager
    end

    # destroy a menu ghost
    def destroy
        # redirect unless admin or manager
    end

    # update menu ghosts remotely
    # ADD A ROUTE
    def data
        # update menu ghosts based on query
    end
end
