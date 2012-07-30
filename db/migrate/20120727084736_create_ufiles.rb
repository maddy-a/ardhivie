class CreateUfiles < ActiveRecord::Migration
  def change
    create_table :ufiles do |t|
      t.string :name

      t.timestamps
    end
  end
end
