class AdTypesController < ApplicationController
    include Fetchable

    def index
    end

    def show
    end

    def new
        if current_user.has_role? :admin
            @ad_type = AdType.new
        else
            return redirect_to home_path,
                notice: "You do not have access to this page."
        end
    end

    def edit
        unless current_user.has_role? :admin
            return redirect_to home_path,
                notice: "You do not have access to this page."
        end
    end

    def create
        @ad_type = AdType.new(ad_type_params)

        respond_to do |format|
            if current_user.has_role? :admin
                if @ad_type.save
                    flash[:notice] = "Ad type was successfully created."
                    format.html { redirect_to @ad_type }
                    format.json { render :show, status: :created,
                        location: @ad_type,
                        json: { success: true }}
                else
                    format.html { render :new }
                    format.json { render status: :unprocessable_entity,
                        json: { success: false, errors: @ad_type.errors}}
                end
            else
                no_permission
            end
        end
    end

    def update
        respond_to do |format|
            if current_user.has_role? :admin
                if @ad_type.update(ad_type_params)
                    flash[:notice] = "Ad type was successfully updated."
                    format.html { redirect_to @ad_type }
                    format.json { render :show, status: :created,
                        location: @ad_type,
                        json: { success: true }}
                else
                    format.html { render :new }
                    format.json { render status: :unprocessable_entity,
                        json: { success: false, errors: @ad_type.errors}}
                end
            else
                no_permission
            end
        end
    end

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

    private :data_params
    private :search_params
    private :ad_type_params
end
