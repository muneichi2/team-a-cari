class UsersController < ApplicationController

  def index
    @user = User.new
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    @user.update(identification_params)
    @user.save
    redirect_to "/users/#{current_user.id}/registrate"
  end

  def destroy
  end

  def sales
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end

  def identification_params
    params.require(:user).permit(:first_name, :last_name, :first_reading, :last_reading, :postal_code, :prefecture, :city, :address, :building_name, :birth_year, :birth_month, :birth_day)
  end
end
