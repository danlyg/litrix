class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(current_user.id)


  end


  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.age = current_age(@user.birthdate)
    @user.current_weeks = current_weeks(@user.birthdate)


    @lifedatum = Lifedatum.find_by_country_and_gender(:country => @user.country, :gender => @user.gender )
    #hardcoded for now
    # country, sex
    @user.gender
    @user.country



    @user.total_life = 100
    @user.total_weeks = @user.total_life*52

    respond_to do |format|
      if @user.save
        login(@user)
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        @user.age = current_age(@user.birthdate)
        @user.current_weeks = current_weeks(@user.birthdate)
        @user.save
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :gender, :country, :password, :password_confirmation, :email, :birthdate)
    end

end
