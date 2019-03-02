class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # 通常HelperModuleで定義されたメソッドは、Viewでのみ使用できる
  # includeを使うことで、module内のメソッド(def～end)を自身のクラスにインスタンスメソッドとして、定義することができる。
  # これはModule内のメソッドを自分のクラスにコピペするようなもの。
  # これをMix-inという。Lesson5-11参照
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_users = user.tasks.count
  end
  
end
