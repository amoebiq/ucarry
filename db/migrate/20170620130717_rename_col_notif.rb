class RenameColNotif < ActiveRecord::Migration
  def change

    rename_column :ccnotifications,:type,:notif_type

  end
end
