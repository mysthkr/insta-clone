class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :ensure_current_user, only: [:edit, :update]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to pictures_path, notice: "ユーザ登録しました！"
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)
     if @user.update(user_params)
      redirect_to edit_user_path(current_user.id), notice: "ユーザ情報を編集しました！"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,:user_image, :user_image_cache,
                                 :password_confirmation)
  end
  
  def ensure_current_user
    if @current_user.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to new_session_path
    end
  end
end
