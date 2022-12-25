class Admin::AccessCodesController < Admin::AdminController

  include AuthenticatedController

  def index
    @codes = AccessCode.page(params[:page])
  end

  def new
    @code = AccessCode.new
  end

  def create
    @code = AccessCode.new(code_params)
    if @code.save
      redirect_to admin_access_codes_path, notice: t('admin.access_codes.flash.created', code: @code.code)
    else
      flash.now[:alert] = t('validation_error')
      render :new
    end
  end

  def update
    @code = AccessCode.find_by! id: params[:id]
    if @code.update(code_params)
      redirect_to admin_access_codes_path, notice: t('admin.access_codes.flash.updated', code: @code.code)
    else
      flash.now[:alert] = t('validation_error')
      render :edit
    end
  end

  def destroy
    @code = AccessCode.find_by! id: params[:id]
    @code.destroy!
    redirect_to admin_access_codes_path, notice: t('admin.access_codes.flash.deleted', code: @code.code)
  end

  def edit
    @code = AccessCode.find_by! id: params[:id]
  end

private

  def code_params
    params.require(:access_code).permit(:name, :code, :active)
  end

end
