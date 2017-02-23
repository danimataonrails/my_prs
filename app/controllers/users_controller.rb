class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]
  
  def index
    authorize :user, :index?
    load_users
    respond_to do |format|
      format.html
      format.xml { render :xml => @users.to_xml }
      format.json { render :json => @users.to_json }
    end
  end
  
  def new
    authorize :user, :new?
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    authorize @user, :create?
    if @user.save
      flash[:notice] = ''
      redirect_to users_path
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    authorize @user, :show?
  end
  
  def edit
    authorize @user, :edit?
  end
  
  def update
    authorize @user, :update?
    if @user.update_attributes(user_params)
      flash[:notice] = ''
      if current_user.id == @user.id
        bypass_sign_in(@user)
      end
      redirect_to policy(User).index? ? users_path : user_path(current_user)
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    authorize @user, :destroy?
    if @user.destroy
      flash[:notice] = ''
    else
      flash[:errors] = ''
    end
    redirect_to users_path
  end
  
  private
  
  def load_user
    @user = params.has_key?(:id) ? policy_scope(User).find(params[:id]) : nil
  end

  def load_users
    @users = policy_scope(User.all).page(params[:page])
  end

  def user_params
    params.require(:user).permit(policy(:user).permitted_attributes)
  end
end
