class TagsController < ApplicationController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_action :set_tag, only: [:show, :destroy]

    def index
    end

    # show a review
    def show
    end

    # form for creating a new review for a cart
    def new
        @tag = Tag.new
    end

    # create a new review for a cart
    def create
        @tag = Tag.new(tag_params)
        @tag.count = 0

        respond_to do |format|
            if @tag.save
                format.html { redirect_to @tag,
                    notice: 'You successfully created a tag.' }
                format.json { render :show, status: :created,
                    location: @ucr,
                    :json => { :success => true }}
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    :json => { :success => false, :errors => @tag.errors}}
            end
        end
    end

    def destroy
        respond_to do |format|
            if current_user.has_role? :admin
                @tag.destroy

                format.html { redirect_to :back,
                    notice: 'You successfully destroyed this tag.' }
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
        if params[:tag].empty?
            @tags = Tag.limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        else
            @tags = Tag.where(data_params)
                .limit(search_params["limit"].to_i)
                .offset(search_params["offset"].to_i)
        end

        render :status => 200,
            :json => { :success => true, :data => @tags }
    end

    def data_params
        params.require(:tag).permit(:id, :name, :count)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def tag_params
        params.require(:tag).permit(:name)
    end

    def set_tag
        @tag = Tag.find(params[:id])
    end

    private :data_params
    private :search_params
    private :tag_params
    private :set_tag
end
