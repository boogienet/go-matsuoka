require "business_time"

class Project < ActiveRecord::Base
  before_save :update_calculated_fields
  belongs_to :project_type

  has_many :planned_commitments
  has_many :planned_resources, 
    :through => :planned_commitments,
    :class_name => "Resource",
    :source => :resource

  has_many :actuals

  def update_calculated_fields
    unless self.start_date.nil? || self.end_date.nil?
      self.working_days = self.start_date.business_days_until(self.end_date)
    end
  end

end
