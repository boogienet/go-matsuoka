class Resource < ActiveRecord::Base
  validates_presence_of :name, :short_name

  belongs_to :resource_type

  has_many :planned_commitments
  has_many :projects,
    :through => :planned_commitments,
    :class_name => 'Project',
    :source => :project

  has_many :service_commitments
  has_many :services,
    :through => :service_commitments,
    :class_name => 'Service',
    :source => :service

  has_many :actuals

  scope :active, -> {
    where('end_date is NULL or end_date = \'\' or end_date > ?' ,Date.today)
  }

  def self.accessible_attributes
    ['name', 'short_name', 'key', 'start_date', 'end_date']
  end

  def planned_projects
    projects.where('start_date > ?', Date.today)
  end
  def active_projects
    projects.where('start_date <= ? and end_date >= ?', Date.today, Date.today)
  end
  def completed_projects
    projects.where('end_date < ?', Date.today)
  end

  def commited?(params = Date.today)
    if params.is_a?(Hash)

    end
    if params.is_a?(Date)
      return commited_on? params
    end
    if params.is_a?(String)
      return commited_on? Date.parse(params)
    end
  end

  def commited_on?(params)
    commitment = 0
    service_commitment = 0
    project_commitment = 0
    services.active_on?(params).each do |service|
      service_commitment += service.service_commitments.find_by_resorce_id(id).effort
    end
    projects.active_on?(params).each do |project|
      project_commitment += project.planned_commitments.find_by_resource_id(id).effort
    end
    commitment = service_commitment + project_commitment
    {:total_commitment=>commitment, :services=>service_commitment, :projects=>project_commitment}
  end
end
