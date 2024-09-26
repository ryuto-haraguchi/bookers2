class BooksController < ApplicationController
  def create
    @book = Book.new(book_params)
    @user = @book.user.id
    @book.save
    redirect_to books_path
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book_user = Book.find(params[:id])
    @user = @book_user.user
    @book = Book.new
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
