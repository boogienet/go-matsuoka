class PlannedCommitment < ActiveRecord::Base
  belongs_to :resource
  belongs_to :project

  before_save :ensure_commitment_recorded

  def ensure_commitment_recorded
    if effort.nil? || effort.empty?
      self.effort = 100
    end
    if duration.nil? || duration.empty?
      self.duration = 100
    end
  end

end
