module Fetchable
    extend ActiveSupport::Concern

    included do
        skip_before_filter :verify_authenticity_token,
            :if => Proc.new { |c| c.request.format == 'application/json' }

        before_filter :authenticate_user!, only: [:new, :create, :update, :destroy]
        skip_before_filter :authenticate_user!,
            :if => Proc.new { |c| current_owner != nil }

        before_filter :authenticate_owner!, only: [:new, :create, :update, :destroy]
        skip_before_filter :authenticate_owner!,
            :if => Proc.new { |c| current_user != nil }

        before_action :set_instance, only: [:show, :edit, :update, :destroy]

        respond_to :json
        def data
            name = params[:controller][0...-1]
            klass = name.capitalize.constantize

            if params[name].empty?
                @results = klass.limit(search_params["limit"].to_i)
                    .offset(search_params["offset"].to_i)
            else
                @results = klass.where(data_params)
                    .limit(search_params["limit"].to_i)
                    .offset(search_params["offset"].to_i)
            end

            render :status => 200, :json => { :success => true,
                :data => @results }
        end

    end

    def set_instance
        name = params[:controller][0...-1]
        klass = name.capitalize.constantize

        self.instance_variable_set("@#{name}", klass.find(params[:id]))
    end

    private :set_instance
end
