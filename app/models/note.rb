class Note < ActiveRecord::Base
    belongs_to :user
    belongs_to :menu_item

    validates :text, :user, :menu_item, presence: true
    validates :user_id, uniqueness: {:scope => :menu_item_id,
        :message => "Users may only write one note per menu item."}

    def as_json(options={})
        options[:only] = [:id, :text, :user_id, :menu_item_id]
    end
end
