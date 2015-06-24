class Admin::UsersController < ApplicationController
  before_filter :require_admin

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "Successfully created user #{@user.id}, #{@user.firstname}!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path 
    else
      render :edit
    end
  end

  protected

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end
