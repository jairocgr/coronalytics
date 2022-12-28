class SragReportJob < ApplicationJob
  queue_as :default

  BATCH_SIZE = 2048

  def perform(srag)
    srag.mutex(40.minutes) do
      report(srag)
    end
  end

private
  def report(srag)
    # The median age of brazil is 27.9
    report = SragReportMaker.new
    nrecords = srag.records.count

    srag.update! status: Srag::GEN_REPORT

    logger.info "Generating report for #{srag.year} (#{nrecords} records, release date #{srag.release_date})"

    srag.records.find_each(batch_size: BATCH_SIZE) do |record|
      report.add(record)
    end

    srag.vaccination_numbers.each do |vaccination|
      report.add_vaccination_numbers(vaccination)
    end

    report.summarize

    puts "New report for #{srag.year} (#{srag.release_date}) is done"
    srag.update! report: report.to_hash, status: Srag::REPORT_DONE

  ensure
    srag.update status: Srag::REPORT_ERROR unless srag.status == Srag::REPORT_DONE
  end
end
