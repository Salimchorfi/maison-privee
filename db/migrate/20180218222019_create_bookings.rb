class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.string :location
      t.string :artist
      t.string :service
      t.time :time

      t.timestamps
    end
  end
end
