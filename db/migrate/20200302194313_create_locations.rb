class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :country, default: nil
      t.string :place, default: nil
    end
  end
end
