class BookCommentsController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		@book_comment = current_user.book_comments.new(book_comment_params)
		@book_comment.book_id = @book.id
	    if @book_comment.save
	       redirect_to book_path(@book)
	    else
            @user = @book.user
	    	render template: "books/show"
	    end
	end

	def destroy
		@book = Book.find(params[:book_id])
		@comment = BookComment.find(params[:book_id])
		if @comment.user_id == current_user.id
		   @comment.destroy
		   redirect_to book_path(@book)
		else
			redirect_to book_path(@book)
		end
	end
	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end

end
