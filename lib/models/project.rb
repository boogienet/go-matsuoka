require "business_time"

class Project < ActiveRecord::Base
  before_save :update_calculated_fields
  belongs_to :project_type

  # http://blog.hasmanythrough.com/2006/5/6/through-gets-uniq
  has_many :planned_commitments
  has_many :resources,
    :through => :planned_commitments,
    :class_name => "Resource",
    :source => :resource

  has_many :actuals

  def update_calculated_fields
    unless self.short_name.nil? || self.short_name.empty?
      self.short_name = self.short_name.downcase
    end
    unless self.start_date.nil? || self.end_date.nil?
      self.working_days = self.start_date.business_days_until(self.end_date)
    end
  end

  def planned_effort
    project_working_days = working_days
    man_days = 0
    planned_commitments.each do |commitment|
      man_days = man_days + (project_working_days * (commitment.duration / 100) * (commitment.effort / 100)) 
    end
    man_days 
  end

  def actual_effort
    actuals.sum(:hours) / 7.5
  end

end
