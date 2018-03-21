class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.string :status
      t.string :sender
      t.string :language
      t.integer :count
      t.string :tags, array: true, default: []

      t.timestamps
    end
  end
end
