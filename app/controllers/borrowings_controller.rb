class BorrowingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    if @book.available?
      @borrowing = Borrowing.new(user: current_user, book: @book, due_date: 2.weeks.from_now)
      if @borrowing.save
        redirect_to user_path(current_user), notice: "Book borrowed successfully."
      else
        redirect_to book_path(@book), alert: "Failed to borrow book."
      end
    else
      redirect_to book_path(@book), alert: "Book is not available."
    end
  end

  def destroy
    @borrowing = Borrowing.find(params[:id])
    if @borrowing.destroy
      redirect_to user_path(current_user), notice: "Book returned successfully."
    else
      redirect_to user_path(current_user), alert: "Failed to return book."
    end
  end
end