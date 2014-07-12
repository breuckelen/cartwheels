class SearchController < ApplicationController
    def index
        @total = Cart.search("id", search_params["tq"],
                search_params["lq"], search_params["categories"],
                search_params["box"]).count
        Rails.logger.info(@total.methods)
        @carts = Cart.search("popularity", search_params["tq"],
                search_params["lq"], search_params["categories"],
                search_params["box"])
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)
        @reviews = Review.search(search_params["tq"], search_params["lq"])
        @checkins = Checkin.search(search_params["tq"], search_params["lq"])
        @tq = search_params["tq"]
        @lq = search_params["lq"]
        @offset = search_params["offset"].to_i
    end

    def search_params
        ps = params.permit(:offset, :limit, :sort_by, :tq, :lq,
            :categories, :box)
        defaults = {"offset" => 0, "limit" => 20, "categories" => [],
            "box" => []}
        defaults.merge(ps)
    end
end
