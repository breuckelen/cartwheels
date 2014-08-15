class CategoriesController < ApplicationController
    include Fetchable

    def index
    end

    def show
    end

    def new
        @category = Category.new
    end

    def create
        user = current_user
        user ||= current_owner

        @category = Category.new(category_params)
        @category.count = 0

        respond_to do |format|
            if @category.save
                format.html { redirect_to @category,
                    notice: 'You successfully created a category.' }
                format.json { render :show, status: :created,
                    location: @category,
                    json: { success: true }}
                format.js {render "shared/concerns/login",
                    locals: {errors: nil, redirect_path: last_path(user)}}
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    json: { success: false, errors: @category.errors}}
                format.js {render "shared/concerns/login",
                    locals: {errors: @category.errors}}
            end
        end
    end

    def destroy
        respond_to do |format|
            if current_user.has_role? :admin
                @category.destroy

                format.html { redirect_to :back,
                    notice: 'You successfully destroyed this category.' }
                format.json { render json: { success: true } } else
                format.html { redirect_to :back,
                    notice: 'You do not have permission to perform this action.'
                }
                format.json { render json: { success: false } }
            end
        end
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

    private :data_params
    private :search_params
    private :category_params
end
