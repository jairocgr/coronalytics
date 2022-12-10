
require 'json'

class SragReportMaker

  attr_accessor :deaths, :hospitalizations, :icus, :vaccination, :summary

  def initialize
    @deaths = []
    @hospitalizations = []
    @icus = []
    @summary = {}
    @vaccination = []

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

      vaccination.append({
        month: month,
        one_dose: 0,
        two_doses: 0,
      })
    end

    summary[:deaths] = ({
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

    summary[:hospitalizations] = ({
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

    summary[:icus] = ({
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

  def add(record)
    add_deaths(record) if record.evolucao == 2 and record.dt_evoluca.present?
    add_hospitalizations(record) if record.hospital == 1 and record.dt_interna.present?
    add_icus(record) if record.uti == 1 and record.dt_entuti.present?
  end

  def add_vaccination_numbers(vaccination_number)
    month_index = vaccination_number.month - 1
    report = vaccination[month_index]

    report[:one_dose] += vaccination_number.one_dose
    report[:two_doses] += vaccination_number.two_doses

    vaccination[month_index] = report
  end

  def summarize
    summarize_deaths
    summarize_hospitalizations
    summarize_icus
  end

  def to_hash
    return {
      deaths: deaths,
      hospitalizations: hospitalizations,
      icus: icus,
      vaccination: vaccination,
      summary: summary,
    }
  end

private

  def summarize_hospitalizations
    hospitalizations.each do |record|
      summary[:hospitalizations][:total] += record[:total]
      summary[:hospitalizations][:vaccinated] += record[:vaccinated]
      summary[:hospitalizations][:unvaccinated] += record[:unvaccinated]
      summary[:hospitalizations][:fully_vaccinated] += record[:fully_vaccinated]
      summary[:hospitalizations][:undef] += record[:undef]
    end

    total = summary[:hospitalizations][:vaccinated] + summary[:hospitalizations][:unvaccinated]
    total = 1 if total == 0

    summary[:hospitalizations][:vaccinated_percentage] = (summary[:hospitalizations][:vaccinated]*100) / total
    summary[:hospitalizations][:unvaccinated_percentage] = (summary[:hospitalizations][:unvaccinated]*100) / total
    summary[:hospitalizations][:fully_vaccinated_percentage] = (summary[:hospitalizations][:fully_vaccinated]*100) / total

    # Undef. percentage is calculated in relation with the real total
    summary[:hospitalizations][:undef_percentage] = (summary[:hospitalizations][:undef]*100) / summary[:hospitalizations][:total]
  end

  def summarize_deaths
    deaths.each do |record|
      summary[:deaths][:total] += record[:total]
      summary[:deaths][:vaccinated] += record[:vaccinated]
      summary[:deaths][:unvaccinated] += record[:unvaccinated]
      summary[:deaths][:fully_vaccinated] += record[:fully_vaccinated]
      summary[:deaths][:undef] += record[:undef]
    end

    total = summary[:deaths][:vaccinated] + summary[:deaths][:unvaccinated]
    total = 1 if total == 0

    summary[:deaths][:vaccinated_percentage] = (summary[:deaths][:vaccinated]*100) / total
    summary[:deaths][:unvaccinated_percentage] = (summary[:deaths][:unvaccinated]*100) / total
    summary[:deaths][:fully_vaccinated_percentage] = (summary[:deaths][:fully_vaccinated]*100) / total

    # Undef. percentage is calculated in relation with the real total
    summary[:deaths][:undef_percentage] = (summary[:deaths][:undef]*100) / summary[:deaths][:total]
  end

  def summarize_icus
    icus.each do |record|
      summary[:icus][:total] += record[:total]
      summary[:icus][:vaccinated] += record[:vaccinated]
      summary[:icus][:unvaccinated] += record[:unvaccinated]
      summary[:icus][:fully_vaccinated] += record[:fully_vaccinated]
      summary[:icus][:undef] += record[:undef]
      summary[:icus][:vaccinated_percentage] += record[:vaccinated_percentage]
      summary[:icus][:unvaccinated_percentage] += record[:unvaccinated_percentage]
      summary[:icus][:fully_vaccinated_percentage] += record[:fully_vaccinated_percentage]
      summary[:icus][:undef_percentage] += record[:undef_percentage]
    end

    total = summary[:icus][:vaccinated] + summary[:icus][:unvaccinated]
    total = 1 if total == 0

    summary[:icus][:vaccinated_percentage] = (summary[:icus][:vaccinated]*100) / total
    summary[:icus][:unvaccinated_percentage] = (summary[:icus][:unvaccinated]*100) / total
    summary[:icus][:fully_vaccinated_percentage] = (summary[:icus][:fully_vaccinated]*100) / total

    # Undef. percentage is calculated in relation with the real total
    summary[:icus][:undef_percentage] = (summary[:icus][:undef]*100) / summary[:icus][:total]
  end

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
    month[:fully_vaccinated_percentage] = (month[:fully_vaccinated]*100) / total

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

    if record.fully_vaccinated? then
      report[:fully_vaccinated] += 1
    end


    total = report[:vaccinated] + report[:unvaccinated]
    total = 1 if total == 0

    report[:vaccinated_percentage] = (report[:vaccinated]*100) / total
    report[:unvaccinated_percentage] = (report[:unvaccinated]*100) / total
    report[:fully_vaccinated_percentage] = (report[:fully_vaccinated]*100) / total

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
    report[:fully_vaccinated_percentage] = (report[:fully_vaccinated]*100) / total

    # Undef. percentage is calculated in relation with the real total
    report[:undef_percentage] = (report[:undef]*100) / report[:total]

    icus[month_index] = report
  end

end
