class ReviewsController < ApplicationController
    include Fetchable

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
                flash[:notice] = "Review was successfully created."
                format.html { redirect_to @review }
                format.json { render status: :created,
                    location: @review,
                    json: { success: true }}
                format.js { render "shared/concerns/form_multiple",
                        locals: {cart: @review.cart, errors: nil,
                            model: "review"},
                        status: :created
                }
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    json: { success: false, errors: @review.errors}}
                format.js { render "shared/concerns/form_multiple",
                        locals: {cart: @review.cart,
                            errors: @review.errors, model: "review"},
                        status: :unprocessable_entity
                }
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
                    json: { success: true }}
            else
                format.html { render :edit }
                format.json { render status: :unprocessable_entity,
                    json: { success: false, errors: @review.errors}}
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
                format.json { render json: { success: true } }
            else
                format.html { redirect_to cart,
                    notice: 'You do not have permission to perform this action.'
                }
                format.json { render json: { success: false } }
            end
        end
    end

    def search
        @reviews = Review.search(search_params["tq"], search_params["lq"])
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)

        render :status => 200, :json => { :success => true,
            :data => @reviews }
    end

    def data_params
        params.require(:review).permit(:id, :user_id, :cart_id)
    end

    def search_params
        ps = params.permit(:offset, :limit, :lq, :tq)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def review_params
        params.require(:review).permit(:text, :rating, :cart_id)
    end

    private :data_params
    private :search_params
    private :review_params
end
