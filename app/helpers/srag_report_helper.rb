
module SragReportHelper

  def get_srag_from(year)
    Srag.order(release_date: 'DESC').where(year: year, status: Srag::REPORT_DONE).first!
  end

  def month_name(month_number)
    Date::ABBR_MONTHNAMES[month_number]
  end

end
