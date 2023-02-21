class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :ensure_current_user_edit_posted_picture, only: [:edit, :update]
  
  def index
    @pictures = Picture.all
    @users = User.all
    # @favorite = @favorites.where(user_id: current_user.id)
    @favorites = Favorite.all.where(user_id: current_user.id)
  end
  
  def new
    @picture = Picture.new
  end
  
  def create
    @picture = current_user.pictures.build(post_params)
    # @picture = Picture.new(post_params)
    
    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to pictures_path, notice: "投稿しました！"
      else
        render :new
      end
    end
  end
  
  def show
    @picture = Picture.find(params[:id])
  end
  
  def edit
    @picture = Picture.find(params[:id])
  end
  
  def update
    @picture = Picture.find(params[:id])
     if @picture.update(post_params)
      redirect_to pictures_path, notice: "投稿を編集しました！"
    else
      render :edit
    end
  end
  
  def favo
    # @favorite = current_user.favorites.find(user_id: params[:id])
    @favorites = Favorite.where(user_id: current_user.id)
    @pictures = Picture.all
    @users = User.all
  end
  
  def confirm
    @picture = current_user.pictures.build(post_params)
    render :new if @picture.invalid?
  end
  
  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"投稿を削除しました！"
  end
  
  private
  
  def set_picture
    @picture = Picture.find(params[:id])
  end

  def post_params
    params.require(:picture).permit(:image, :image_cache, :comment)
  end
  
  def ensure_current_user_edit_posted_picture
    @picture = Picture.find(params[:id])
    if @current_user.id != @picture.user_id
      flash[:notice]="権限がありません"
      redirect_to pictures_path
    end
  end
end
