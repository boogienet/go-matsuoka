class Project < ActiveRecord::Base
  before_save :update_calc_data

  belongs_to :project_type

  has_many :planned_commitments
  has_many :resources, :through => :planned_commitments

  has_many :actuals
  
  private

  def update_calc_data

  end
end
