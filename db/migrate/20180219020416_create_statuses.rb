class CreateStatuses < ActiveRecord::Migration[5.0]
  enable_extension 'hstore' unless extension_enabled?('hstore')

  def change
    create_table :statuses do |t|
      t.string :status
      t.string :sender
      t.string :language
      t.integer :count
      t.string :location
      t.string :intent
      t.hstore :log, default: { :vieuxMontreal => 0,
                                   :villeMarie => 0,
                                      :mileEnd => 0,
                                     :quartier => 0,
                                       :rudsak => 0,
                                      :academy => 0}, null: false


      t.timestamps
    end
  end
end



