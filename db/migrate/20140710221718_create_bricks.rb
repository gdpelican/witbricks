class CreateBricks < ActiveRecord::Migration
  def change
    create_table :bricks do |t|
      t.string 	:quote
      t.string 	:author
      t.integer :order
      t.timestamps
    end
  end
end
