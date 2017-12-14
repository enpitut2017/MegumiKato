class RemoveOldSensorsFromPositions < ActiveRecord::Migration[5.1]
  def change
    remove_column :positions, :press0, :integer
    remove_column :positions, :press1, :integer
    remove_column :positions, :press2, :integer
    remove_column :positions, :press3, :integer
    remove_column :positions, :bend0, :integer
    remove_column :positions, :bend1, :integer
  end
end
