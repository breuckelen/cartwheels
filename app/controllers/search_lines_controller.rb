class SearchLinesController < ApplicationController
    include Fetchable

    def index
        @search_lines = SearchLine.all
    end

    def show
    end

    def new
        @search_line = SearchLine.new
    end

    def edit
    end

    def create
        @search_line = SearchLine.new(search_history: current_user.search_history)

        respond_to do |format|
            if @search_line.save
                terms = search_line_params[:terms].strip.split
                terms.each do |term|
                    token = SearchToken.find_or_initialize_by(term: term)
                    token.search_lines << @search_line
                    token.save
                end

                format.html { redirect_to search_lines_path,
                    notice: 'Search line was succesfully created.' }
                format.json { render :show, status: :created,
                    location: @search_line,
                    json: { success: true }}
            else
                format.html { render :new }
                format.json { render json: @search_line.errors,
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
                @search_line.destroy

                format.html { redirect_to search_lines_path,
                    notice: 'Search line was successfully destroyed.' }
                format.json { render json: { success: true } }
            else
                format.html { redirect_to @search_line,
                    notice: 'You do not have permission to perform this action.'
                }
                format.json { render json: { success: false } }
            end
        end
    end

    def data_params
        params.require(:search_line).permit(:id)
    end

    def search_params
        ps = params.permit(:offset, :limit)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    def search_line_params
        params.require(:search_line).permit(:terms)
    end

    private :data_params
    private :search_params
    private :search_line_params
end
