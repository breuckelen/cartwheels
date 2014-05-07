class CreateMenuSuggestionsUsersJoinTable < ActiveRecord::Migration
  def change
      create_table :menu_suggestions_users do |t|
          t.integer :menu_suggestion_id
          t.integer :user_id
      end
  end
end
