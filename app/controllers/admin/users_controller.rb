class Admin::UsersController < Admin::AdminController

  def index
    @user_filter = Admin::UserFilter.new(filter_params)
    @users = User.filter(@user_filter).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    User.transaction do
      @user = User.new(user_params)
      if @user.save
        UserActivationMailer.activate(@user).deliver
        notice = t('admin.users.flash.created', name: @user.name, email: @user.email)
        redirect_to admin_users_path, notice: notice
      else
        flash.now[:alert] = t('validation_error')
        render :new
      end
    end
  end

  def update
    @user = User.non_deleted.find_by! id: params[:id]
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('admin.users.flash.updated', name: @user.name)
    else
      flash.now[:alert] = t('validation_error')
      render :edit
    end
  end

  def destroy
    @user = User.find_by! id: params[:id]
    @user.update! deleted: true
    redirect_to admin_users_path, notice: t('admin.users.flash.deleted', name: @user.name)
  end

  def edit
    @user = User.non_deleted.find_by! id: params[:id]
  end

private
  def filter_params
    if params.has_key? :admin_user_filter
      params.require(:admin_user_filter).permit(:name, :email)
    end
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
