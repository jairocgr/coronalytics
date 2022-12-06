class Admin::SragsController < Admin::AdminController

  include AuthenticatedController

  def ingest
    @srag = Srag.find_by!(params[:id])
    IngestSragFileJob.perform_later(@srag)
    @srag.update! status: 'SCHEDULED'
  end

  def index
    @srags = Srag.page(params[:page])
  end

end
