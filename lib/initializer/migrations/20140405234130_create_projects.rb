require 'active_record'

class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :short_name
      t.integer :project_type_id
      t.date :start_date
      t.date :end_date
      t.integer :working_days
      t.text :wbs
    end
  end
end
