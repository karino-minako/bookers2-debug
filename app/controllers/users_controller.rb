class UsersController < ApplicationController
before_action :authenticate_user!


  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end


  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施
    @user = current_user
  end

  def edit
  	@user = User.find(params[:id])
    if current_user.id != @user.id
       redirect_to user_path(current_user.id)
    end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
       flash[:notice] = "successfully updated user!"
       redirect_to user_path(@user.id)
  	else
  		 render action: :edit
  	end
  end

  def following
      @user = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
      @user = User.find(params[:id])
      @users = @user.followers
      render 'show_follower'
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
