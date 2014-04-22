require 'active_record'

class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.date :start_date
      t.integer :planned_duration
      t.text :wbs
    end
  end
end
