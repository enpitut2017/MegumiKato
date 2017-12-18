class CreateBicycles < ActiveRecord::Migration[5.1]
  def change
    create_table :bicycles do |t|
      t.string :serial, nil: false
      t.references :user, foreign_key: true, nil: false
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
