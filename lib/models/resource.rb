class Resource < ActiveRecord::Base
  validates_presence_of :name, :short_name

  belongs_to :resource_type

  has_many :planned_commitments
  has_many :planned_projects,
    :through => :planned_commitments,
    :class_name => "Project",
    :source => :project

  has_many :actuals
end
