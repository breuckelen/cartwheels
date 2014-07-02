class CategoriesController < ApplicationController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_action :set_category, only: [:show, :destroy]

    def index
    end

    # show a review
    def show
    end

    # form for creating a new review for a cart
    def new
        @category = Category.new
    end

    # create a new review for a cart
    def create
        @category = Category.new(category_params)
        @category.count = 0

        respond_to do |format|
            if @category.save
                format.html { redirect_to @category,
                    notice: 'You successfully created a category.' }
                format.json { render :show, status: :created,
                    location: @ucr,
                    :json => { :success => true }}
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    :json => { :success => false, :errors => @category.errors}}
            end
        end
    end

    def destroy
        respond_to do |format|
            if current_user.has_role? :admin
                @category.destroy

                format.html { redirect_to :back,
                    notice: 'You successfully destroyed this category.' }
                format.json { render json: {
                    success: true } }
            else
                format.html { redirect_to :back,
                    notice: 'You do not have permission to perform this action.' }
                format.json { render json: {
                    success: false }
                }
            end
        end
    end

    respond_to :json
    def data
        if params[:category].empty?
            @categories = Category.limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        else
            @categories = Category.where(data_params)
                .limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        end

        render :status => 200,
            :json => { :success => true, :data => @categories }
    end

    def data_params
        params.require(:category).permit(:id, :name, :count)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def category_params
        params.require(:category).permit(:name)
    end

    def set_category
        @category = Category.find(params[:id])
    end

    private :data_params
    private :search_params
    private :category_params
    private :set_category
end
