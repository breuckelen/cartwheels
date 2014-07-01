class ReviewsController < ApplicationController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_action :set_review, only: [:show, :edit, :update, :destroy]

    def index
    end

    # show a review
    def show
    end

    # form for creating a new review for a cart
    def new
        @review = Review.new
    end

    def edit
    end

    # create a new review for a cart
    def create
        @review = current_user.reviews.build(review_params)
        @review.cart_id = params[:cart_id]

        respond_to do |format|
            if @review.save
                format.html { redirect_to @review,
                    notice: 'Review was succesfully created.' }
                format.json { render :show, status: :created,
                    location: @review,
                    :json => { :success => true }}
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    :json => { :success => false, :errors => @review.errors}}
            end
        end
    end

    def update
        respond_to do |format|
            if @review.update(review_params)
                format.html { redirect_to @review,
                    notice: 'Review was succesfully updated.' }
                format.json { render :show, status: :ok,
                    location: @review,
                    :json => { :success => true }}
            else
                format.html { render :edit }
                format.json { render status: :unprocessable_entity,
                    :json => { :success => false, :errors => @review.errors}}
            end
        end
    end

    def destroy
        cart = @review.cart

        respond_to do |format|
            if current_user == @review.user or current_user.has_role? :admin
                @review.destroy

                format.html { redirect_to cart,
                    notice: 'Review was successfully destroyed.' }
                format.json { render json: {
                    success: true } }
            else
                format.html { redirect_to cart,
                    notice: 'You do not have permission to perform this action.' }
                format.json { render json: {
                    success: false }
                }
            end
        end
    end

    respond_to :json
    def data
        @reviews = Review.where(data_params)
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)

        render :status => 200,
            :json => { :success => true, :data => @reviews }
    end

    def search
    end

    def data_params
        params.require(:review).permit(:id, :user_id, :cart_id)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def review_params
        params.require(:review).permit(:text, :rating, :cart_id)
    end

    def set_review
        @review = Review.find(params[:id])
    end

    private :data_params
    private :search_params
    private :review_params
    private :set_review
end
