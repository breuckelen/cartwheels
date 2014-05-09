class CreateCartSuggestionsUsersJoinTable < ActiveRecord::Migration
    def change
        create_table :cart_suggestions_users do |t|
            t.integer :cart_suggestion_id
            t.integer :user_id
        end

        add_index :cart_suggestions_users, :cart_suggestion_id
        add_index :cart_suggestions_users, :user_id
    end
end
