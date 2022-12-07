
module SragReportHelper

  class SragReporter

    def deaths(year)
      srag = get_srag_from(year)
      result = []

      (1..12).each do |month|
        result.append({
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
      end

      return result
    end

    def vaccination(year)
      result = []
      (1..6).each do |month|
        vaccination = VaccinationNumber.where(year: year).where(month: month).first!
        result.append({
          month: month,
          one_dose: vaccination.one_dose,
          two_doses: vaccination.two_doses,
        })
      end
      return result
    end

    def get_srag_from(year)
      Srag.order(release_date: 'DESC').where(year: year).first!
    end

  end

  def month_name(month_no)
    Date::ABBR_MONTHNAMES[month_no]
  end

end
