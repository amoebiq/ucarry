class AddColumnToSenderDetail < ActiveRecord::Migration
  def change
    add_column :sender_details, :avatar_content_type, :string
  end
end
