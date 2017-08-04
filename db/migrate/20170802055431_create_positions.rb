class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.string :serial
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
