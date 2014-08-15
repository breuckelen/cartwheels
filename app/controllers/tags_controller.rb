class TagsController < ApplicationController
    include Fetchable

    def index
    end

    def show
    end

    def new
        @tag = Tag.new
    end

    def create
        user = current_user
        user ||= current_owner

        @tag = Tag.new(tag_params)
        @tag.count = 0

        respond_to do |format|
            if @tag.save
                format.html { redirect_to @tag,
                    notice: 'You successfully created a tag.' }
                format.json { render :show, status: :created,
                    location: @tag,
                    json: { success: true }}
                format.js {render "shared/concerns/login",
                    locals: {errors: nil, redirect_path: last_path(user)}}
            else
                format.html { render :new }
                format.json { render status: :unprocessable_entity,
                    json: { success: false, errors: @tag.errors}}
                format.js {render "shared/concerns/login",
                    locals: {errors: @tag.errors}}
            end
        end
    end

    def destroy
        respond_to do |format|
            if current_user.has_role? :admin
                @tag.destroy

                format.html { redirect_to :back,
                    notice: 'You successfully destroyed this tag.' }
                format.json { render json: { success: true } } else
                format.html { redirect_to :back,
                    notice: 'You do not have permission to perform this action.'
                }
                format.json { render json: { success: false } }
            end
        end
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

    private :data_params
    private :search_params
    private :tag_params
end
