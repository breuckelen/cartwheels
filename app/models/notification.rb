class Notification < ActiveRecord::Base
    # associations
    belongs_to :cart

    # validations
    validates :description, presence: true
end
