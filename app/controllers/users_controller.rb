class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
    authorize @user
  end

  def edit
    @user = User.find params[:id]
    authorize @user
  end

  def update
    @user = User.find params[:id]
    authorize @user
    if @user.update_attributes params.require(:user).permit(:email, :name, :gender)
      redirect_to @user, notice: 'You have updated your profile successfully.'
    else
      render :edit
    end
  end
end
