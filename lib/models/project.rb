require "business_time"

class Project < ActiveRecord::Base
  before_save :update_calculated_fields
  belongs_to :project_type

  # http://blog.hasmanythrough.com/2006/5/6/through-gets-uniq
  has_many :planned_commitments
  has_many :planned_resources,
    :through => :planned_commitments,
    :class_name => "Resource",
    :source => :resource

  # TODO: scope for active projects
  
  has_many :actuals

  def update_calculated_fields
    unless self.start_date.nil? || self.end_date.nil?
      self.working_days = self.start_date.business_days_until(self.end_date)
    end
  end

  def planned_effort
    project_working_days = working_days
    man_days = 0
    planned_commitments.each do |commitment|
      man_days = man_days + (project_working_days * (commitment.percentage / 100)) 
    end
  
    man_days 
  end

end
