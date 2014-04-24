require 'active_record'

class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :short_name
      t.date :start_date
      t.integer :duration_in_days
      t.integer :working_days
      t.text :wbs
    end
  end
end
