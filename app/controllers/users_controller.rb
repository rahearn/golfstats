class UsersController < ApplicationController

  before_filter :load_user
  authorize_resource

  def show
  end

  private

  def load_user
    @user = current_user
  end
end
