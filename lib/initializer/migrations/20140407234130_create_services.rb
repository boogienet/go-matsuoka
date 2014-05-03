require 'active_record'

class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :short_name
      t.date :start_date
      t.date :end_date
      t.integer :working_days
      t.text :wbs
    end
  end
end
