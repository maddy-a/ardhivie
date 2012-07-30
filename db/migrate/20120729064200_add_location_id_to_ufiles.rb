class AddLocationIdToUfiles < ActiveRecord::Migration
  def change
    add_column :ufiles, :location_id, :integer
  end
end
