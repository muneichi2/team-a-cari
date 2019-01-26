class UsersController < ApplicationController

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def identify
  end

  def pay_way
  end

  def add_card
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end
end
