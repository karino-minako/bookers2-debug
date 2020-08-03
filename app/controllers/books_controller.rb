class BooksController < ApplicationController
before_action :authenticate_user!, only: [:show, :index, :edit]
  def top
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
  end

  def about
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    @book_comments = @book.book_comments
  end

  def index
    @books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book = Book.new
    @user = current_user
    @all_ranks = Book.find(Favorite.group(:book_id).order('count(book_id) desc').limit(3).pluck(:book_id))
  end

  def create
    @book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
    if @book.save #入力されたデータをdbに保存する。
       flash[:notice] = "successfully created book!"
       redirect_to book_path(@book) #保存された場合の移動先を指定。
    else
       @books = Book.all
       @user = current_user
       render action: :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if current_user.id != @book.user.id
       redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "successfully updated book!"
       redirect_to book_path(@book) 
    else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
      render action: :edit
    end
  end

  def destroy
      book = Book.find(params[:id])
      book.destroy
      flash[:notice] = "successfully delete book!"
      redirect_to books_path
  end



  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
