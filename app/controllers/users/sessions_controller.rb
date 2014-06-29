class Users::SessionsController < Devise::SessionsController
    before_filter :authenticate_basic_http
end
