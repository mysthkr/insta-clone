class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  
  def index
    @pictures = Picture.all
    @users = User.all
  end
  
  def new
    @picture = Picture.new
  end
  
  def create
    # @picture = current_user.pictures.build(post_params)
    @picture = Picture.new(post_params)
    
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
end
