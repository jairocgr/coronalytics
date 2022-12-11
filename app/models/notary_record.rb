
class NotaryRecord < ApplicationRecord
  
  def expected_deaths
    return death_record_before + (death_record_before * avg_increase).floor
  end
  
  def excess_deaths_increase
    return ((excess_deaths / expected_deaths.to_f) * 100).round(half: :up)
  end
  
  def expected_worst_case
    return expected_deaths + (expected_deaths * std_dev_increase).floor
  end
  
  def expected_best_case
    return expected_deaths - (expected_deaths * std_dev_increase).floor
  end
  
  def excess_deaths
    return deaths - expected_deaths
  end
  
  def excess_worst
    return deaths - expected_worst_case
  end
  
  def excess_best
    return deaths - expected_best_case
  end
  
  def excess_death_result
    if excess_deaths_increase > 0 then
      "bad"
    elsif excess_deaths_increase < 0
      "good"
    else
      "neutral"
    end
  end

private
  
  def death_record_before
    if record_before.pandemic_year? then
      record_before.expected_deaths
    else
      record_before.deaths
    end
  end
  
  def avg_increase
    @avg_increase ||= calc_avg_increase
  end
  
  def std_dev_increase
    @std_dev_increase ||= calc_std_dev_increase
  end
  
  def record_before
    @record_before ||= NotaryRecord.where(year: year-1).first
  end
  
  def prepandemic_records
    @prepandemic_records ||= NotaryRecord.where(pandemic_year: false).order(year: 'ASC')
  end
  
  def calc_avg_increase
    increases = calc_increases()
    return increases.sum(0) / increases.size
  end
  
  def calc_std_dev_increase
    increases = calc_increases()
    mean = increases.sum(0) / increases.size
    sum = increases.sum(0.0) { |element| (element - mean) ** 2 }
    variance = sum / (increases.size - 1)
    standard_deviation = Math.sqrt(variance)
    return standard_deviation
  end
  
  def calc_increases
    previus = nil
    increases = []
    prepandemic_records.each do |record|
      if previus.present?
        increases.append (record.deaths - previus.deaths).to_f / previus.deaths
      end
      previus = record
    end
    return increases
  end
  
end
