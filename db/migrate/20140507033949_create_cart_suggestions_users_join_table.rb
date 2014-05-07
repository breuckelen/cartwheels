class CreateCartSuggestionsUsersJoinTable < ActiveRecord::Migration
  def change
      create_table :cart_suggestions_users do |t|
          t.integer :cart_suggestion_id
          t.integer :user_id
      end
  end
end
