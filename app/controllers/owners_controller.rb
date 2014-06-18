class OwnersController < ApplicationController
    def show
        @user = Owner.find(params[:id])

        unless @owner == current_owner
            redirect_to :back, :alert => "Access denied."
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

    # action for editing pictures and menus
    # ADD ROUTE
    def edit_content
        # redirect unless owner of the cart
    end

    # action for editing information
    # ADD ROUTE
    def edit_info
        # redirect unless owner of the cart
    end

    # action for editing ads
    # ADD ROUTE
    def edit_ads
        # redirect unless owner of the cart
    end
end
