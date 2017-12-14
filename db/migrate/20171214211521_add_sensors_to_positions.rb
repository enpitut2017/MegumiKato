class AddSensorsToPositions < ActiveRecord::Migration[5.1]
  def change
    add_column :positions, :press_zero, :float
    add_column :positions, :press_one, :float
    add_column :positions, :press_two, :float
    add_column :positions, :press_three, :float
    add_column :positions, :accel_x, :float
    add_column :positions, :accel_y, :float
    add_column :positions, :accel_z, :float
  end
end
