class AddAttachmentDataToUfiles < ActiveRecord::Migration
  def self.up
    change_table :ufiles do |t|
      t.has_attached_file :data
    end
  end

  def self.down
    drop_attached_file :ufiles, :data
  end
end
