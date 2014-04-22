class Project < ActiveRecord::Base
  belongs_to :project_type

  has_many :planned_commitments
  has_many :resources, :through => :planned_commitments

  has_many :actuals
end
