class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
    authorize @users
  end

  def show
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy

    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role).tap { |params| params[:role] = params[:role].to_i }
    end

    def set_user
      @user = User.find_by(id: params[:id])
      authorize @user
    end
end
