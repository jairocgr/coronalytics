class Admin::NotaryRecordsController < Admin::AdminController

  include AuthenticatedController

  def index
    @records = NotaryRecord.page(params[:page])
  end

  def new
    @record = NotaryRecord.new
  end

  def create
    @record = NotaryRecord.new(record_params)
    if @record.save
      redirect_to admin_notary_records_path, notice: t('admin.notary_records.flash.created', year: @record.year)
    else
      flash.now[:alert] = t('validation_error')
      render :new
    end
  end

  def update
    @record = NotaryRecord.find_by! id: params[:id]
    if @record.update(record_params)
      redirect_to admin_notary_records_path, notice: t('admin.notary_records.flash.updated', year: @record.year)
    else
      flash.now[:alert] = t('validation_error')
      render :edit
    end
  end

  def destroy
    @record = NotaryRecord.find_by! id: params[:id]
    @record.destroy!
    redirect_to admin_notary_records_path, notice: t('admin.notary_records.flash.deleted', year: @record.year)
  end

  def edit
    @record = NotaryRecord.find_by! id: params[:id]
  end

private

  def record_params
    params.require(:notary_record).permit(:year, :deaths, :pandemic_year)
  end

end
