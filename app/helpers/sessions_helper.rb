module SessionsHelper
  # ここに定義したものは全てのViewで使える
  # Controllerではデフォルトでは使えない
  def current_user
    @current_user ||=User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !!current_user
  end
end