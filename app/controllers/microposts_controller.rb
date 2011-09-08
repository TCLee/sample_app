class MicropostsController < ApplicationController  
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end
  
  private
  
    def authorized_user
      # For SECURITY purposes, it's always good practice to run lookups
      # via the association.
      # Use this: current_user.microposts.find_by_id(params[:id])
      # Instead of this: Micropost.find_by_id(params[:id])
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end
end