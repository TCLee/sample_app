class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def index
    @title = "All Users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def new
    if signed_in?
      redirect_to root_path
    else
      @user = User.new
      @title = "Sign Up"
    end
  end
  
  def create
    if signed_in?
      redirect_to root_path
    else
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        @title = "Sign Up"
        @user.password = ""
        @user.password_confirmation = ""
        render 'new'
      end
    end    
  end
  
  def edit
    @title = "Edit User"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'
    end
  end
  
  def destroy    
    @user = User.find(params[:id])    
    if current_user != @user
      @user.destroy
      flash[:success] = "User destroyed."
    else
      flash[:error] = "Cannot delete your ownself." 
    end
    redirect_to users_path
  end
  
  def following    
    show_follow(:following)
  end
  
  def followers
    show_follow(:followers)
  end
  
  private
  
    def show_follow(action)
      @title = action.to_s.capitalize
      @user = User.find(params[:id])
      @users = @user.send(action).paginate(:page => params[:page])
      render 'show_follow'
    end
      
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user? @user
    end
    
    def admin_user      
      redirect_to root_path unless current_user.admin?
    end
end
