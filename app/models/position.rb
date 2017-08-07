class Position < ApplicationRecord
  def as_json(options={})
    { id: self.id, serial: self.serial, latitude: self.latitude.to_f, longitude: self.longitude.to_f, created_at: self.created_at, updated_at: self.updated_at }
  end
end
