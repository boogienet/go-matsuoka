require "business_time"

class Service < ActiveRecord::Base
  before_save :update_calculated_fields

  # http://blog.hasmanythrough.com/2006/5/6/through-gets-uniq
  has_many :service_commitments
  has_many :resources,
    :through => :service_commitments,
    :class_name => "Resource",
    :source => :resource

  # has_many :actuals

  scope :active, -> { 
    # end date is before today, and start date is after today
    where("end_date > ? and start_date < ?", Date.today, Date.today)
  }
  scope :active_on?, ->(whichday) {
    where("end_date > ? and start_date < ?", whichday, whichday)
  }

  def update_calculated_fields
    unless self.short_name.nil? || self.short_name.empty?
      self.short_name = self.short_name.downcase
    end
    unless self.start_date.nil? || self.end_date.nil?
      self.working_days = self.start_date.business_days_until(self.end_date)
    end
  end

end
