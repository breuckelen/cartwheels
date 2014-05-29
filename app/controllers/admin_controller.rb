class AdminController < ApplicationController
    # main page for admins and managers to manage content
    def index
        # redirect unless an admin or a manager
        # html:
        # if is an admin
        #   - show search statistics
        # else
        #   - interface for searching / deleting content
    end

    # main page
    # ADD A ROUTE
    def carts
        # redirect unless an admin
        # html:
        # show clickthrough statistics
        # show carts, allow searches on them
        # show cart ghosts, allow searches, allow approval / deletion
        # show menu ghosts, allow all abilities above
        # show images, allow deletion
    end

    # page listing the pruning tasks running
    # ADD A ROUTE
    def tasks
        # redirect unless an admin
        # html:
        # stop and start bots
        # show statistics on the bots
    end

    # show traffic statistics for the site
    # ADD A ROUTE
    def traffic
        # redirect unless an admin or a manager
    end
end
