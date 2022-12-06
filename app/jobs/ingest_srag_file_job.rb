
require 'open-uri'

class IngestSragFileJob < ApplicationJob
  queue_as :default

  def perform(srag)
    tmpfile = download(srag)
    begin
      logger.info("Downloaded #{tmpfile} to '#{tmpfile.path}'!")
    ensure
      tmpfile.close
      tmpfile.unlink
    end
  end

private

  def download(srag)
    src = URI.open(srag.url)
    tmpfile = Tempfile.new("srag-{#{srag.id}}")
    logger.info("Downloading #{srag.url} to '#{tmpfile.path}'")
    IO.copy_stream(src, tmpfile)
    return tmpfile
  end

end
