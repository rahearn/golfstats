class UsersController < ApplicationController

  load_and_authorize_resource

  def show
    @user.extend ImportLegacy
  end

end
