class BooksController < ApplicationController
	before_action :authenticate_user!

  def show
	  @mybook = Book.find(params[:id])
	  @book = Book.new
	  @user = User.find(@mybook.user_id)
	  @book_comment = BookComment.new
  end

  def index
	  @books = Book.all 
	  @book = Book.new
  end

  def create
		@book = Book.new(book_params) 
		@book.user_id = current_user.id
  	if	@book.save 
  		redirect_to book_path(@book.id), notice: "successfully created book!"
  	else
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
	@book = Book.find(params[:id])
    if  @book.user_id != current_user.id
        redirect_to books_path
    end
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else 
  		render "edit"
  	end
  end

  def delete
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
