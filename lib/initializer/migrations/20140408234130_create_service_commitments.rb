require 'active_record'

class CreateServiceCommitments < ActiveRecord::Migration
  def change
    create_table :service_commitments do |t|
      t.integer :service_id
      t.integer :resource_id
      t.float :effort
    end
  end
end
