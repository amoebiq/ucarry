class AddAvatartToSenderDetail < ActiveRecord::Migration
  def change
    add_column :sender_details, :avatar_file_name, :string
    add_column :sender_details, :avatar_file_size ,:integer
    add_column :sender_details, :avatar_updated_at ,:datetime
  end
end
