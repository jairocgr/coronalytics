
require 'json'

class SragReport

  attr_accessor :deaths, :hospitalizations, :icus

  def initialize
    @deaths = []
    @hospitalizations = []
    @icus = []

    (1..12).each do |month|
      deaths.append({
        month: month,
        total: 0,
        vaccinated: 0,
        unvaccinated: 0,
        fully_vaccinated: 0,
        undef: 0,
        vaccinated_percentage: 0,
        unvaccinated_percentage: 0,
        fully_vaccinated_percentage: 0,
        undef_percentage: 0,
      })
      hospitalizations.append({
        month: month,
        total: 0,
        vaccinated: 0,
        unvaccinated: 0,
        fully_vaccinated: 0,
        undef: 0,
        vaccinated_percentage: 0,
        unvaccinated_percentage: 0,
        fully_vaccinated_percentage: 0,
        undef_percentage: 0,
      })
      icus.append({
        month: month,
        total: 0,
        vaccinated: 0,
        unvaccinated: 0,
        fully_vaccinated: 0,
        undef: 0,
        vaccinated_percentage: 0,
        unvaccinated_percentage: 0,
        fully_vaccinated_percentage: 0,
        undef_percentage: 0,
      })
    end
  end

  def add(record)
    add_deaths(record) if record.evolucao == 2 and record.dt_evoluca.present?
    add_hospitalizations(record) if record.hospital == 1 and record.dt_interna.present?
    add_icus(record) if record.uti == 1 and record.dt_entuti.present?
  end

  def to_hash
    return {
      deaths: deaths,
      hospitalizations: hospitalizations,
      icus: icus,
    }
  end

private

  def add_deaths(record)
    death_date = record.dt_evoluca
    death_month = death_date.mon

    # Don't count if it happened outside it's SRAG time window
    return unless record.srag.inside_time_window? death_date

    month_index = death_month - 1
    month = deaths[month_index]

    month[:total] += 1

    if record.vaccinated? then
      month[:vaccinated] += 1
    elsif record.unvaccinated?  then
      month[:unvaccinated] += 1
    else
      month[:undef] += 1
    end

    if record.dose_2_cov.present? then
      month[:fully_vaccinated] += 1
    end


    total = month[:vaccinated] + month[:unvaccinated]
    total = 1 if total == 0

    month[:vaccinated_percentage] = (month[:vaccinated]*100) / total
    month[:unvaccinated_percentage] = (month[:unvaccinated]*100) / total
    month[:fully_vaccinated_percentage] = (month[:fully_vaccinated]*100) / month[:total]

    # Undef. percentage is calculated in relation with the real total
    month[:undef_percentage] = (month[:undef]*100) / month[:total]

    deaths[month_index] = month
  end

  def add_hospitalizations(record)
    hospitalization_date = record.dt_interna
    hospitalization_month = hospitalization_date.mon

    # Don't count if it happened outside it's SRAG time window
    return unless record.srag.inside_time_window? hospitalization_date

    month_index = hospitalization_month - 1
    report = hospitalizations[month_index]

    report[:total] += 1

    if record.vaccinated? then
      report[:vaccinated] += 1
    elsif record.unvaccinated?  then
      report[:unvaccinated] += 1
    else
      report[:undef] += 1
    end

    if record.dose_2_cov.present? then
      report[:fully_vaccinated] += 1
    end


    total = report[:vaccinated] + report[:unvaccinated]
    total = 1 if total == 0

    report[:vaccinated_percentage] = (report[:vaccinated]*100) / total
    report[:unvaccinated_percentage] = (report[:unvaccinated]*100) / total
    report[:fully_vaccinated_percentage] = (report[:fully_vaccinated]*100) / report[:total]

    # Undef. percentage is calculated in relation with the real total
    report[:undef_percentage] = (report[:undef]*100) / report[:total]

    hospitalizations[month_index] = report
  end

  def add_icus(record)
    icu_date = record.dt_entuti
    icu_month = icu_date.mon

    # Don't count if it happened outside it's SRAG time window
    return unless record.srag.inside_time_window? icu_date

    month_index = icu_month - 1
    report = icus[month_index]

    report[:total] += 1

    if record.vaccinated? then
      report[:vaccinated] += 1
    elsif record.unvaccinated?  then
      report[:unvaccinated] += 1
    else
      report[:undef] += 1
    end

    if record.dose_2_cov.present? then
      report[:fully_vaccinated] += 1
    end


    total = report[:vaccinated] + report[:unvaccinated]
    total = 1 if total == 0

    report[:vaccinated_percentage] = (report[:vaccinated]*100) / total
    report[:unvaccinated_percentage] = (report[:unvaccinated]*100) / total
    report[:fully_vaccinated_percentage] = (report[:fully_vaccinated]*100) / report[:total]

    # Undef. percentage is calculated in relation with the real total
    report[:undef_percentage] = (report[:undef]*100) / report[:total]

    icus[month_index] = report
  end

end
