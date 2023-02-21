class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :ensure_current_user, only: [:edit, :update]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to pictures_path
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def ensure_current_user
    if @current_user.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to new_session_path
    end
  end
end
