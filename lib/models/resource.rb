class Resource < ActiveRecord::Base
  validates_presence_of :name, :key
  belongs_to :resource_type
end
