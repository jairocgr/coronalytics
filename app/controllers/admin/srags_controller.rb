class Admin::SragsController < Admin::AdminController

  include AuthenticatedController

  def ingest
    @srag = Srag.find_by! id: params[:id]
    IngestSragFileJob.perform_later(@srag)
    @srag.update! status: 'SCHEDULED'
  end

  def index
    @srags = Srag.page(params[:page])
  end

end
