RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
     warden.authenticate! scope: :user
     unless current_user.has_role?(:admin)
         flash[:error] = "You are not an admin"
         redirect_to root_path
     end
  end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Model Configuration ==
  config.model 'Cart' do
      list do
          field :photo do
              formatted_value do
                  bindings[:view].tag(:img, {
                      :src => bindings[:object].admin_image_url})
              end
          end
          field :name
          field :description
          field :city
      end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
