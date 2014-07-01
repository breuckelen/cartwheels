class ClickthroughsController < ApplicationController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_action :set_clickthrough, only: [:show, :edit, :update, :destroy]

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
                    :json => { :success => true }}
            else
                format.json { render json: @clickthrough.errors,
                    status: :unprocessable_entity,
                    :json => { :success => false }}
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
                format.json { render json: {
                    success: true } }
            else
                format.html { redirect_to clickthroughs_path,
                    notice: 'You do not have permission to perform this action.' }
                format.json { render json: {
                    success: false }
                }
            end
        end
    end

    respond_to :json
    def data
        @clickthroughs = Clickthrough.where(data_params)
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)

        render :status => 200, :json => { :success => true,
            :data => @clickthroughs }
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

    def set_clickthrough
        @clickthrough = Clickthrough.find(params[:id])
    end

    private :data_params
    private :search_params
    private :clickthrough_params
    private :set_clickthrough
end
