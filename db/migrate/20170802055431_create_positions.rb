class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.string :serial
      t.float :latitude
      t.float :longitude
      t.float :press_zero
      t.float :press_one
      t.float :press_two
      t.float :press_three
      t.float :accel_x
      t.float :accel_y
      t.float :accel_z
      t.timestamps
    end
  end
end
