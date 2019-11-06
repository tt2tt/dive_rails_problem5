class Admin::UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update, :destroy]

  USER_PER = 8
  TASK_PER = 5

  def index
    @users=User.sort_by_id.includes(:tasks).page(params[:page]).per(USER_PER)
  end

  def new
    @user = User.new
  end

  def show
    @tasks = @user.tasks.page(params[:page]).per(TASK_PER)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'ユーザーを作成しました'
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: 'ユーザーを編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました'
    else
      redirect_to admin_users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user= User.find(params[:id])
  end

end
