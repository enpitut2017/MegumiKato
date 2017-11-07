class Position < ApplicationRecord
  def as_json(options={})
    { id: self.id, serial: self.serial, latitude: self.latitude.to_f, longitude: self.longitude.to_f, press_zero: self.press_zero.to_f, press_one: self.press_one.to_f, press_two: self.press_two.to_f, press_three: self.press_three.to_f, accel_x: self.accel_x.to_f, accel_y: self.accel_y.to_f, accel_z: self.accel_z.to_f ,created_at: self.created_at, updated_at: self.updated_at }
  end
end
