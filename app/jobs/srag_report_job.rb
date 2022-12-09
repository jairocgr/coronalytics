class SragReportJob < ApplicationJob
  queue_as :default

  def perform(srag)

    # The median age of brazil is 27.9
    report = SragReport.new
    nrecords = srag.records.where('nu_idade_n > 27').count

    logger.info "Generating report for #{srag.year} (#{nrecords} records, release date #{srag.release_date})"

    srag.records.find_each do |record|
      report.add(record)
    end

    puts "New report for #{srag.year} is done"
    srag.update! report: report.to_hash

  end
end
