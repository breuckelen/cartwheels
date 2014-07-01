class DropStartDateAndEndDateFromAds < ActiveRecord::Migration
  def change
    remove_column :ads, :start_date
    remove_column :ads, :end_date
  end
end
