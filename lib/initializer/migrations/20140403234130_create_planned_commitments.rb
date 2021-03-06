require 'active_record'

class CreatePlannedCommitments < ActiveRecord::Migration
  def change
    create_table :planned_commitments do |t|
      t.integer :resource_id
      t.integer :project_id
      t.float :effort
      t.float :duration
      t.integer :order
    end
  end
end
