class Resource < ActiveRecord::Base
  validates_presence_of :name, :short_name

  belongs_to :resource_type

  has_many :planned_commitments
  has_many :projects,
    :through => :planned_commitments,
    :class_name => "Project",
    :source => :project

  has_many :service_commitments
  has_many :services,
    :through => :service_commitments,
    :class_name => "Service",
    :source => :service

  has_many :actuals

  scope :active, -> {
    where("end_date is NULL or end_date = '' or end_date > ?" ,Date.today)
  }

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

  def commitment(*params)
  end

end
