class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.float :average
      t.float :minimun
      t.float :maximum
      t.float :lost

      t.timestamps null: false
    end
  end
end
