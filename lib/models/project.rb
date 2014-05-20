require 'business_time'

class Project < ActiveRecord::Base
  before_save :update_calculated_fields
  belongs_to :project_type

  # http://blog.hasmanythrough.com/2006/5/6/through-gets-uniq
  has_many :planned_commitments
  has_many :resources,
    :through => :planned_commitments,
    :class_name => "Resource",
    :source => :resource

  scope :active, -> {
    # end date is before today, and start date is after today
    where("end_date > ? and start_date < ?", Date.today, Date.today)
  }
  scope :active_on?, ->(whichday) {
    where("end_date > ? and start_date < ?", whichday, whichday)
  }
  scope :planned, -> {
    where("start_date > ?", Date.today)
  }
  scope :completed, -> {
    where("end_date < ?", Date.today)
  }

  has_many :actuals

  # push a project forward but keep duration
  def move_start_date(new_start_date)
    working_days = self.working_days
    self.start_date = new_start_date
    if new_start_date.is_a?(String)
      self.start_date = Date.parse(new_start_date)
    end
    self.end_date = working_days.business_days.after(self.start_date)
    save
  end

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
      unless commitment.resource.end_date.nil?
        project_working_days = project_working_days - commitment.resource.end_date.business_days_until(end_date)
      end
      man_days = man_days + (project_working_days * (commitment.duration / 100) * (commitment.effort / 100))
    end
    man_days
  end

  def actual_effort
    actuals.sum(:hours) / 7.5
  end

end
