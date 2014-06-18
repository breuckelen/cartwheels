class CreateSearchLinesTokens < ActiveRecord::Migration
  def change
    create_table :search_lines_tokens do |t|
        t.integer :search_line_id
        t.integer :search_token_id
    end
  end
end
