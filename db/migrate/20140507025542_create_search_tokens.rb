class CreateSearchTokens < ActiveRecord::Migration
  def change
    create_table :search_tokens do |t|
        t.string :term
        t.integer :count, :default => 0
    end
  end
end
