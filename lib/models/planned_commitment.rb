class PlannedCommitment < ActiveRecord::Base
  belongs_to :resource
  belongs_to :project
end
