class AddSecurityStatusToBicycles < ActiveRecord::Migration[5.1]
  def change
    add_column :bicycles, :status, :boolean, default: false, null: false
  end
end
