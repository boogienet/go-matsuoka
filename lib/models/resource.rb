class Resource < ActiveRecord::Base
  validates_presence_of :name, :nickname
  belongs_to :resource_type

  has_many :planned_commitments
  has_many :projects, :through => :planned_commitments

  has_many :actuals
end
