class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @borrowings = @user.borrowings.includes(:book)
  end
end