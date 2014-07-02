module ApplicationHelper
    def flash_class(level)
        case level
            when "notice" then return "alert alert-info alert-abs"
            when "success" then return "alert alert-success alert-abs"
            when "error" then return "alert alert-warning alert-abs"
            when "alert" then return "alert alert-danger alert-abs"
        end
    end
end
