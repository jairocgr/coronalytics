class Admin::SragsController < Admin::AdminController

  include AuthenticatedController

  def ingest
    @srag = Srag.find_by! id: params[:id]
    IngestSragFileJob.perform_later(@srag)
    @srag.update! status: 'SCHEDULED'
  end

  def gen_report
    @srag = Srag.find_by! id: params[:id]
    SragReportJob.perform_later(@srag)
    redirect_to admin_srags_path, notice: "Running report on year <b>#{@srag.year}</b>"
  end

  def index
    @srags = Srag.page(params[:page])
  end

end
