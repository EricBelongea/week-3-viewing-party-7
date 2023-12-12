class UsersController <ApplicationController 
  def new 
    @user = User.new
  end 

  def show 
    @user = User.find(params[:id])
  end 

  def create 
    # require 'pry'; binding.pry
    if params[:user][:password] == params[:user][:password_confirmation]
      user = User.create(user_params)
      if user.save
        redirect_to user_path(user)
      else  
        flash[:error] = user.errors.full_messages.to_sentence
        redirect_to register_path
      end 
    else
      flash[:error] = "Passwords must match"
      redirect_back(fallback_location: register_path)
    end
  end 

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password)
  end 
end 