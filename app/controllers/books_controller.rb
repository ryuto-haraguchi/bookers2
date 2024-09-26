class BooksController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update, :destroy]

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

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end

end
