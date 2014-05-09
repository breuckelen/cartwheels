class CreateMenuSuggestionsUsersJoinTable < ActiveRecord::Migration
    def change
        create_table :menu_suggestions_users do |t|
            t.integer :menu_suggestion_id
            t.integer :user_id
        end

        add_index :menu_suggestions_users, :menu_suggestion_id
        add_index :menu_suggestions_users, :user_id
    end
end
