class ViewingPartiesController < ApplicationController 
  before_action :require_current_user, only: %w[new create]

  def new
      @user = User.find(params[:user_id])
      @movie = Movie.find(params[:movie_id])
  end 
  
  def create 
      user = User.find(params[:user_id])
      user.viewing_parties.create(viewing_party_params)
      redirect_to dashboard_path(current_user.id)
  end 

  private 

  def require_current_user
    flash[:error] = "You must be logged in or register an account in order to go to your dashboard"
    redirect_to root_path
  end

  def viewing_party_params 
    params.permit(:movie_id, :duration, :date, :time)
  end 
end 