class UsersController < ApplicationController

  load_and_authorize_resource

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes params[:user]
      redirect_to @user, notice: 'You have updated your profile successfully.'
    else
      render :edit
    end
  end
end
