module ApplicationHelper
    def flash_class(level)
        case level
            when "notice" then return "alert alert-info alert-abs"
            when "success" then return "alert alert-success alert-abs"
            when "error" then return "alert alert-warning alert-abs"
            when "alert" then return "alert alert-danger alert-abs"
        end
    end

    def n_to_day(n)
        case n
            when 1 then return "Monday"
            when 2 then return "Tuesday"
            when 3 then return "Wednesday"
            when 4 then return "Thursday"
            when 5 then return "Friday"
            when 6 then return "Saturday"
            when 7 then return "Sunday"
        end
    end

    def n_to_time(n)
        Time.strptime(n, "%H%M").strftime("%l:%M %P")
    end
end
