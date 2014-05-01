class Resource < ActiveRecord::Base
  validates_presence_of :name, :short_name

  belongs_to :resource_type

  has_many :planned_commitments
  has_many :projects,
    :through => :planned_commitments,
    :class_name => "Project",
    :source => :project

  has_many :actuals

  def self.accessible_attributes
    ["name", "short_name", "key", "start_date", "end_date"]
  end

  def planned_projects
    projects.where("start_date > ?", Date.today)
  end
  def active_projects
    projects.where("start_date <= ? and end_date >= ?", Date.today, Date.today)
  end
  def completed_projects
    projects.where("end_date < ?", Date.today)
  end
end
