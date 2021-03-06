class MenuItem < ActiveRecord::Base
    # Relations
    belongs_to :menu
    has_one :photo, as: :target, inverse_of: :target
    has_many :notes

    # Validations
    validates :name, :price, :menu, :photo, presence: true
    validates :price, numericality: true

    def as_json(options={})
        options[:only] ||= [:id, :name, :description, :price, :menu_id]
        options[:include] ||= {
            notes: { only: [:text, :user_id], include: {user: {only: [:name]}}},
            photo: { only: :null, methods: [:image_url, :image_url_large]}
        }
        super(options)
    end
end
