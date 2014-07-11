class SearchController < ApplicationController
    def index
        @carts = Cart.search(search_params["sort_by"], search_params["tq"],
            search_params["lq"])
        @reviews = Review.search(search_params["tq"], search_params["lq"])
        @checkins = Checkin.search(search_params["tq"], search_params["lq"])
        @tq = search_params["tq"]
        @lq = search_params["lq"]
    end

    def search_params
        ps = params.permit(:offset, :limit, :sort_by, :tq, :lq)
        defaults = {"offset" => 0, "limit" => 20, "sort_by" => "popularity"}
        defaults.merge(ps)
    end
end
