class AddTimeToSenderOrderItems < ActiveRecord::Migration

  def change

    add_column :sender_order_items,:start_time,  :datetime
    add_column :sender_order_items,:end_time,  :datetime

  end
end
