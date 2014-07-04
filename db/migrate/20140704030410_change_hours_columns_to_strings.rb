class ChangeHoursColumnsToStrings < ActiveRecord::Migration
    def change
        change_column :hours, :start, :string
        change_column :hours, :end, :string
    end
end
