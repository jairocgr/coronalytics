class Admin::SragsController < Admin::AdminController

  include AuthenticatedController

  def ingest
    @srag = Srag.find_by! id: params[:id]
    @srag.mutex do
      IngestSragFileJob.perform_later(@srag)
      @srag.update! status: Srag::SCHEDULED
    end
  end

  def gen_report
    @srag = Srag.find_by! id: params[:id]
    @srag.mutex do
      if @srag.ingested? then
        SragReportJob.perform_later(@srag)
        redirect_to admin_srags_path, notice: "Report <b>#{@srag.release_date}</b> has been scheduled"
      else
        redirect_to admin_srags_path, alert: "Srag <b>#{@srag.release_date}</b> is not ready to be reported (status <b>#{@srag.status}</b>)"
      end
    end
  end

  def index
    @srags = Srag.page(params[:page])
  end

  def new
    @srag = Srag.new
  end

  def create
    @srag = Srag.new(srag_params)
    if @srag.save
      redirect_to admin_srags_path, notice: t('admin.srags.flash.created', year: @srag.year, release: @srag.release_date)
    else
      flash.now[:alert] = t('validation_error')
      render :new
    end
  end

  def update
    @srag = Srag.find_by! id: params[:id]
    @srag.mutex do
      if @srag.update(srag_params)
        redirect_to admin_srags_path, notice: t('admin.srags.flash.updated', year: @srag.year, release: @srag.release_date)
      else
        flash.now[:alert] = t('validation_error')
        render :edit
      end
    end
  end

  def destroy
    @srag = Srag.find_by! id: params[:id]
    @srag.mutex do
      @srag.destroy!
      redirect_to admin_srags_path, notice: t('admin.srags.flash.deleted', year: @srag.year, release: @srag.release_date)
    end
  end

  def edit
    @srag = Srag.find_by! id: params[:id]
  end

private

  def srag_params
    params.require(:srag).permit(:year, :release_date, :url)
  end

end
