class UsersController < ApplicationController
  include ApiModule
  
  before_action :set_user, only: [:show]
  
  # GET /user
  # GET /user.json
  def index
    @users = User.all
  end


  # GET /user/1
  # GET /user/1.json
  def show
  end

  # GET /user/new
  def new
    @user = User.new
  end

  # POST /user
  # POST /user.json
  def create
    username = user_params[:username]
    if (User.where(username: username).exists?)
       result = get_user(username)
    else
       result = create_user(username)
    end

    respond_to do |format|
        if (result[:is_success])
          format.html { redirect_to result[:data], notice: 'Repositories were successfully retrieved.' }
        else
          flash[:error] = "User wasn't found!"
          format.html { redirect_to action: "new"}
        end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username)
    end
end
