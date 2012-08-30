class AddAttachmentAvatarToUsers < ActiveRecord::Migration
  def self.up
    change_table :ufiles do |t|
      t.has_attached_file :name
    end
  end

  def self.down
    drop_attached_file :ufiles, :name
  end
end
