class ImportsController < ApplicationController

  load_resource :user

  def create
    authorize! :update, @user

    @user.extend ImportLegacy
    @user.import_legacy params[:file]

    if @user.import_successful?
      redirect_to @user, :notice => 'Legacy data successfully imported.'
    else
      flash.now[:alert] = 'There was an error importing your data.'
      render 'users/show'
    end
  end

end
