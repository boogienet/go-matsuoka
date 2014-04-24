require 'active_record'

class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :resource_type_id
      t.string :name
      t.string :nickname
      t.string :key
      t.date :start_date
      t.date :end_date
    end
  end
end
