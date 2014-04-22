require 'active_record'

class CreateProjectTypes < ActiveRecord::Migration
  def change
    create_table :project_types do |t|
      t.string :name
      t.text :notes
    end
  end
end
