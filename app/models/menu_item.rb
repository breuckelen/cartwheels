class MenuItem < ActiveRecord::Base
    # Relations
    belongs_to :menu
    has_one :photo, as: :target, inverse_of: :target
    has_many :notes

    # Validations
    validates :name, :description, :price, :menu, presence: true
    validates :price, numericality: true

    def as_json(options={})
        options[:only] ||= [:id, :description, :price, :menu_id]
        options[:include] ||= {
            notes: { only: [:text, :user_id], include: {user: {only: [:name]}}}
        }
        super(options)
    end
end
