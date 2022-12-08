
module SragReportHelper

  class SragReporter

    MAX_MONTH = 12

    def deaths(year)
      srag = get_srag_from(year)
      result = []

      (1..MAX_MONTH).each do |month|
        record = ({
          month: month,
          total: SragRecord.where(srag: srag)
            .where('year(DT_EVOLUCA) = ?', year)
            .where('month(DT_EVOLUCA) = ?', month)
            .where('evolucao = 2')
            .count,
          vaccinated: SragRecord.where(srag: srag)
            .where('year(DT_EVOLUCA) = ?', year)
            .where('month(DT_EVOLUCA) = ?', month)
            .where('evolucao = 2')
            .where('VACINA_COV = 1')
            .count,
          unvaccinated: SragRecord.where(srag: srag)
            .where('year(DT_EVOLUCA) = ?', year)
            .where('month(DT_EVOLUCA) = ?', month)
            .where('evolucao = 2')
            .where('VACINA_COV = 2')
            .count,
          undef: SragRecord.where(srag: srag)
            .where('year(DT_EVOLUCA) = ?', year)
            .where('month(DT_EVOLUCA) = ?', month)
            .where('evolucao = 2')
            .where('VACINA_COV not in (1,2)')
            .count,
        })

        total = record[:vaccinated]+record[:unvaccinated]
        total = 1 if total == 0

        record[:vaccinated_percentage] = (record[:vaccinated]*100) / total
        record[:unvaccinated_percentage] = (record[:unvaccinated]*100) / total
        record[:undef_percentage] = (record[:undef]*100) / record[:total]

        result.append record
      end

      return result
    end

    def vaccination(year)
      result = []
      (1..MAX_MONTH).each do |month|
        vaccination = VaccinationNumber.where(year: year).where(month: month).first!
        result.append({
          month: month,
          one_dose: vaccination.one_dose,
          two_doses: vaccination.two_doses,
        })
      end
      return result
    end

    def hospitalizations(year)
      srag = get_srag_from(year)
      result = []

      (1..MAX_MONTH).each do |month|
        record = ({
          month: month,
          hospitalizations: SragRecord.where(srag: srag)
            .where('year(DT_INTERNA) = ?', year)
            .where('month(DT_INTERNA) = ?', month)
            .where('HOSPITAL = 1')
            .count,
          hospitalizations_vaccinated: SragRecord.where(srag: srag)
            .where('year(DT_INTERNA) = ?', year)
            .where('month(DT_INTERNA) = ?', month)
            .where('HOSPITAL = 1')
            .where('VACINA_COV = 1')
            .count,
          hospitalizations_unvaccinated: SragRecord.where(srag: srag)
            .where('year(DT_INTERNA) = ?', year)
            .where('month(DT_INTERNA) = ?', month)
            .where('HOSPITAL = 1')
            .where('VACINA_COV = 2')
            .count,
          hospitalizations_undef: SragRecord.where(srag: srag)
            .where('year(DT_INTERNA) = ?', year)
            .where('month(DT_INTERNA) = ?', month)
            .where('HOSPITAL = 1')
            .where('VACINA_COV not in (1,2)')
            .count,

          icus: SragRecord.where(srag: srag)
            .where('year(DT_ENTUTI) = ?', year)
            .where('month(DT_ENTUTI) = ?', month)
            .where('UTI = 1')
            .count,
          icus_vaccinated: SragRecord.where(srag: srag)
            .where('year(DT_ENTUTI) = ?', year)
            .where('month(DT_ENTUTI) = ?', month)
            .where('UTI = 1')
            .where('VACINA_COV = 1')
            .count,
          icus_unvaccinated: SragRecord.where(srag: srag)
            .where('year(DT_ENTUTI) = ?', year)
            .where('month(DT_ENTUTI) = ?', month)
            .where('UTI = 1')
            .where('VACINA_COV = 2')
            .count,
          icus_undef: SragRecord.where(srag: srag)
            .where('year(DT_ENTUTI) = ?', year)
            .where('month(DT_ENTUTI) = ?', month)
            .where('UTI = 1')
            .where('VACINA_COV not in (1,2)')
            .count,
        })

        total = record[:hospitalizations_vaccinated]+record[:hospitalizations_unvaccinated]
        total = 1 if total == 0
        record[:hospitalizations_vaccinated_percentage] = (record[:hospitalizations_vaccinated]*100) / total
        record[:hospitalizations_unvaccinated_percentage] = (record[:hospitalizations_unvaccinated]*100) / total
        record[:hospitalizations_undef_percentage] = (record[:hospitalizations_undef]*100) / record[:hospitalizations]

        total = record[:icus_vaccinated]+record[:icus_unvaccinated]
        total = 1 if total == 0
        record[:icus_vaccinated_percentage] = (record[:icus_vaccinated]*100) / total
        record[:icus_unvaccinated_percentage] = (record[:icus_unvaccinated]*100) / total
        record[:icus_undef_percentage] = (record[:icus_undef]*100) / record[:icus]

        result.append record
      end

      return result
    end

    def get_srag_from(year)
      Srag.order(release_date: 'DESC').where(year: year).first!
    end

  end

  def get_srag_from(year)
    Srag.order(release_date: 'DESC').where(year: year).first!
  end

  def month_name(month_no)
    Date::ABBR_MONTHNAMES[month_no]
  end

end
