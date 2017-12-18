class AddBicycleRefToPositions < ActiveRecord::Migration[5.1]
  def change
    add_reference :positions, :bicycle, foreign_key: true
  end
end
