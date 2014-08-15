class ClickthroughsController < ApplicationController
    include Fetchable

    def index
        @clickthroughs = Clickthrough.all
    end

    def show
    end

    def new
        @clickthrough = Clickthrough.new
    end

    def edit
    end

    def create
        @clickthrough = current_user.clickthroughs
            .find_or_initialize_by(clickthrough_params)
        @clickthrough.count += 1

        respond_to do |format|
            if @clickthrough.save
                format.json { render :show, status: :created,
                    location: @clickthrough,
                    json: { success: true }}
            else
                format.json { render json: @clickthrough.errors,
                    status: :unprocessable_entity,
                    json: { success: false }}
            end
        end
    end

    def update
    end

    def destroy
        respond_to do |format|
            if current_user.has_role? :admin
                @clickthrough.destroy

                format.html { redirect_to clickthroughs_path,
                    notice: 'Clickthrough was successfully destroyed.' }
                format.json { render json: { success: true } }
            else
                format.html { redirect_to clickthroughs_path,
                    notice: 'You do not have permission to perform this action.'
                }
                format.json { render json: { success: false } }
            end
        end
    end

    def data_params
        params.require(:clickthrough).permit(:id, :user_id, :cart_id)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def clickthrough_params
        params.require(:clickthrough).permit(:cart_id)
    end

    private :data_params
    private :search_params
    private :clickthrough_params
end
