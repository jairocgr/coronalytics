
require 'pathname'

class Srag < ApplicationRecord

  has_many :records, class_name: "SragRecord"
  serialize :report, Hash

  def local_path
    Rails.root.join('storage', "srag-#{id}.csv")
  end

  def file_name
    Pathname.new(url).basename
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
