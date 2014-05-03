require 'active_record'

class CreateActuals < ActiveRecord::Migration
  def change
    create_table :actuals do |t|
      t.integer :resource_id
      t.integer :project_id
      t.string :wbs
      t.string :key 
      t.float :hours
    end
  end
end
