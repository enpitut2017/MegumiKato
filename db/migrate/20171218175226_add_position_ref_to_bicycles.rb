class AddPositionRefToBicycles < ActiveRecord::Migration[5.1]
  def change
    add_reference :bicycles, :position, foreign_key: true
  end
end
