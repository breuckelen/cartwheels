class Upload < ActiveRecord::Base
    has_one :cart, dependent: :destroy
    belongs_to :user

    accepts_nested_attributes_for :cart

    validates :cart, presence: true
end
