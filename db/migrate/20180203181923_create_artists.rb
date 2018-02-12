class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
