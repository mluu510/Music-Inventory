class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(self.user_params)

    if @user.save
      self.current_user = @user
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    if params.include?(:id)
      @user = User.find(params[:id])
      render :show
    else
      redirec_to root_url
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
