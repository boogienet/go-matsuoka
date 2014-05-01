require 'active_record'

class CreateResourceTypes < ActiveRecord::Migration
  def change
    create_table :resource_types do |t|
      t.string :name
      t.string :short_name
    end
  end
end
