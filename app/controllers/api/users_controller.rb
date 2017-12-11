class Api::UsersController < ::ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      render :show, status: :created
    else
      unprocessable_entity(@user.errors.full_messages) and return
    end
  end

  def index
    @users = Finders::UserFinderService.new(params).search
  end

  private

  def user_params
    params.permit(:email, :key, :metadata, :password, :phone_number, :full_name)
  end
end
