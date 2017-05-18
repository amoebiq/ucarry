class AddDetailsToUser < ActiveRecord::Migration
  def change


    add_column :users,:aadhar_link , :string
    add_column :users,:voterid_link , :string
    add_column :users,:dl_link , :string
    add_column :users,:verified , :string , :default => 'Not Verified'

  end
end
