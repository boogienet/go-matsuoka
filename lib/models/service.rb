require 'business_time'

class Service < ActiveRecord::Base
  before_save :update_calculated_fields

  # http://blog.hasmanythrough.com/2006/5/6/through-gets-uniq
  has_many :service_commitments
  has_many :resources,
    :through => :service_commitments,
    :class_name => 'Resource',
    :source => :resource

  # has_many :actuals

  scope :active, -> {
    # end date is before today, and start date is after today
    where('end_date > ? and start_date < ?', Date.today, Date.today)
  }
  scope :active_on?, ->(whichday) {
    where('end_date > ? and start_date < ?', whichday, whichday)
  }

  def update_calculated_fields
    unless short_name.nil? || short_name.empty?
      short_name = short_name.downcase
    end
    unless start_date.nil? || end_date.nil?
      working_days = start_date.business_days_until(end_date)
    end
  end
end
