require 'active_record'

class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
    end
  end
end
