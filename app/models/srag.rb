
require 'pathname'
require 'uri'

class Srag < ApplicationRecord

  CREATED      = 'CREATED'
  SCHEDULED    = 'SCHEDULED'
  DOWNLOADING  = 'DOWNLOADING'
  DOWNLOADED   = 'DOWNLOADED'
  PROCESSING   = 'PROCESSING'
  INGESTED     = 'INGESTED'
  ERROR        = 'ERROR'
  GEN_REPORT   = 'GEN_REPORT'
  REPORT_DONE  = 'REPORT_DONE'
  REPORT_ERROR = 'REPORT_ERROR'

  has_many :records, class_name: "SragRecord", dependent: :delete_all
  serialize :report, Hash

  validates :year, presence: true, comparison: { greater_than: 2019, less_than: 2030 }, numericality: { only_integer: true }
  validates :url, presence: true, format: { with: URI::regexp }
  validates :release_date, presence: true

  def mutex(expiration = 1.minutes)
    RedisMutex.with_lock(self, block: 1, expire: expiration) do
      yield
    end
  end

  def local_path
    Rails.root.join('storage', "srag-#{id}.csv")
  end

  def file_name
    Pathname.new(url).basename
  end

  def vaccination_numbers
    @vaccination_numbers ||= VaccinationNumber.where(year: year)
  end

  def inside_time_window?(date)
    # Must be inside the it's year
    return false if date.year != year

    return valid_month? date.mon
  end

  def valid_month?(month)
    # true if this srag is about a past "already-closed" year
    return true if year < Date.today.year

    if month < release_date.mon then
      return true
    else
      return false
    end
  end

end
