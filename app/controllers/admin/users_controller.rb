class Admin::UsersController < Admin::AdminController

  def index
    @user_filter = Admin::UserFilter.new(filter_params)
    @users = User.filter(@user_filter).page(params[:page])
  end

  def destroy
    @user = User.find_by id: params[:id]
    redirect_to admin_users_path, notice: "User #{@user.name} deleted"
  end

  def edit
    @user = User.find_by id: params[:id]
  end

private
  def filter_params
    if params.has_key? :admin_user_filter
      params.require(:admin_user_filter).permit(:name, :email)
    end
  end
end
