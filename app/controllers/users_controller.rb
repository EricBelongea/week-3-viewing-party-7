class UsersController <ApplicationController 
  def new 
    @user = User.new
  end 

  def show 
    if !current_user
      require_current_user
    else
      @user = User.find(current_user.id)
    end
  end 

  def create 
    if params[:user][:password] == params[:user][:password_confirmation]
      user = User.create(user_params)
      if user.save
        session[:user_id] = user.id
        redirect_to dashboard_path(user)
      else  
        flash[:error] = user.errors.full_messages.to_sentence
        redirect_to register_path
      end 
    else
      flash[:error] = "Passwords must match"
      redirect_back(fallback_location: register_path)
    end
  end 

  def login_form; end

  def login_user
    user = User.find_by(email: params[:email])
    if !user 
      flash[:error] = "Invalid email"
      redirect_back(fallback_location: login_path)
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
      redirect_to dashboard_path(user)
    else
      flash[:error] = "Try Again :("
      redirect_back(fallback_location: login_path)
    end
  end

  def log_out
    session.clear
    redirect_to root_path
  end

  private 

  def require_current_user
    flash[:error] = "You must be logged in or register an account in order to go to your dashboard"
    redirect_to root_path
  end

  def user_params 
    params.require(:user).permit(:name, :email, :password)
  end 
end 