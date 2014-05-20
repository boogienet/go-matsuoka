class PlannedCommitment < ActiveRecord::Base

  belongs_to :resource
  belongs_to :project

  before_save :ensure_commitment_recorded

  def self.accessible_attributes
    ['effort', 'duration', 'order']
  end

  def ensure_commitment_recorded
    if effort.nil?
      self.effort = 100
    end
    if duration.nil?
      self.duration = 100
    end
  end
end
