class BookCommentsController < ApplicationController
    
    
    def create
        book = Book.find(params[:book_id])
        book_comment = book.book_comments.new(book_comment_params)
        book_comment.user_id = current_user.id
        book_comment.save
        redirect_back(fallback_location: books_path)
    end

    def destroy
        book_comment = BookComment.find_by(params[:book_id])
        book_comment.destroy
        redirect_back(fallback_location: books_path)
    end

    def book_comment_params
        params.require(:book_comment).permit(:comment)
    end
end
