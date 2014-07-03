class AdTypesController < ApplicationController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_action :set_ad_type, only: [:show, :edit, :update, :destroy]

    # Show all of the ad types available
    def index
    end

    # Show an ad type
    def show
        # html:
        # allow editing capabilities if user is an admin
    end

    # Form for a new ad type
    def new
        @ad_type = AdType.new
    end

    # Edit an ad type
    def edit
    end

    # Create a new ad type
    def create
        @ad_type = AdType.new(ad_type_params)

        respond_to do |format|
            if current_user.has_role? :admin
                if @ad_type.save
                    flash[:notice] = "Ad type was successfully created."
                    format.html { redirect_to @ad_type }
                    format.json { render :show, status: :created,
                        location: @ad_type,
                        :json => { :success => true }}
                else
                    format.html { render :new }
                    format.json { render status: :unprocessable_entity,
                        :json => { :success => false, :errors => @ad_type.errors}}
                end
            else
                no_permission
            end
        end
    end

    # Update an ad type
    def update
        respond_to do |format|
            if current_user.has_role? :admin
                if @ad_type.update(ad_type_params)
                    flash[:notice] = "Ad type was successfully updated."
                    format.html { redirect_to @ad_type }
                    format.json { render :show, status: :created,
                        location: @ad_type,
                        :json => { :success => true }}
                else
                    format.html { render :new }
                    format.json { render status: :unprocessable_entity,
                        :json => { :success => false, :errors => @ad_type.errors}}
                end
            else
                no_permission
            end
        end
    end

    # Destroy an ad type
    def destroy
        respond_to do |format|
            if current_user.has_role? :admin
                @ad_type.destroy

                flash[:notice] = "Ad type was successfully destroyed."
                format.html { redirect_to home_path }
                format.json { render json: { success: true } }
            else
                no_permission
            end
        end
    end

    respond_to :json
    def data
        if params[:ad_type].empty?
            @ad_types = AdType.limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        else
            @ad_types = AdType.where(data_params)
                .limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        end

        render :status => 200,
            :json => { :success => true, :data => @ad_types }
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def data_params
        params.require(:ad_type).permit(:id, :price, :duration)
    end

    def ad_type_params
        params.require(:ad_type).permit(:title, :description, :duration,
            :price)
    end

    def set_ad_type
        @ad_type = AdType.find(params[:id])
    end

    private :data_params
    private :search_params
    private :ad_type_params
    private :set_ad_type
end
