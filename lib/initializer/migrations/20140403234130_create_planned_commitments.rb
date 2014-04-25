require 'active_record'

class CreatePlannedCommitments < ActiveRecord::Migration
  def change
    create_table :planned_commitments do |t|
      t.integer :resource_id
      t.integer :project_id
      t.float :percentage
      t.integer :duration
      t.integer :order
    end
  end
end
