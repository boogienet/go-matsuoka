class ServiceCommitment < ActiveRecord::Base

  belongs_to :resource
  belongs_to :service

  before_save :ensure_effort_recorded

  def self.accessible_attributes
    ["effort"] 
  end

  def ensure_effort_recorded
    if effort.nil?
      self.effort = 100
    end
  end

end
