class AddNameToVolumetric < ActiveRecord::Migration
  def change
    add_column :volumetrics, :name, :string
  end
end
