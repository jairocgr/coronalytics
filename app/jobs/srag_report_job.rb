class SragReportJob < ApplicationJob
  queue_as :default

  def perform(srag)

    report = SragReport.new
    nrecords = srag.records.count

    logger.info "Generating report for #{srag.year} (#{nrecords} records, release date #{srag.release_date})"

    srag.records.find_each do |record|
      report.add(record)
    end

    puts "New report for #{srag.year} is done"
    srag.update! report: report.to_hash

  end
end
