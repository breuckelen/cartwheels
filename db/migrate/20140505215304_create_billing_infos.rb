class CreateBillingInfos < ActiveRecord::Migration
  def change
    create_table :billing_infos do |t|
        t.integer :payable_id
    end
  end
end
