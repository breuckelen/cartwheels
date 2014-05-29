class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])

        unless @user == current_user
            redirect_to :back, :alert => "Access denied."
        end
    end

    def edit
        # redirect unless correct user
    end

    def update
        # redirect unless correct user
    end

    def destroy
        # redirect unless correct user, admin, or manager
    end

    # action for editing subscriptions
    def edit_subs
        # redirect unless correct user
        # html:
        # allow for deletion of subscriptions
    end
end
