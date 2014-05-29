class CreatePhotos < ActiveRecord::Migration
    def change
        create_table :photos do |t|
            t.string :image_url
            t.text :caption
            t.integer :target_id
            t.string :target_type
            t.integer :author_id
            t.integer :author_type

            t.timestamps
        end

        add_index :photos, [:target_id, :target_type]
        add_index :photos, [:author_id, :author_type]
    end
end
