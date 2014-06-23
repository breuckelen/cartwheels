class Badge < ActiveRecord::Base
    # Relations
    has_one :photo, as: :target
    has_and_belongs_to_many :users

    # Validations
    validates :title, presence: true

    def badges_users
        []
    end
end
