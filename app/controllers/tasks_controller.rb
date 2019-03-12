class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    # 下記は全てのタスクを表示する
    # @tasks = Task.all
    # 現在ログインしているユーザーに紐づくデータのみを出したい
    # @←アットマークをつけることによって、対応するビューにその変数を送ることができる。これをインスタンス変数という。
    @tasks = current_user.tasks
  end
  
  def show
    @task = Task.find(params[:id])
    # current_userは現在ログインしているUserクラスのインスタンス
    # 下記をedit,update,destroyにも記載する必要がある。
    # あちこちに同じようなことを書きたくないので、カリキュラムではcorrect_userというメソッドを作って簡略化している。
    if @task.user != current_user
      redirect_to root_url
    end
  end
  
  def new
    # @task = Task.new
    # 以下はログインしているユーザーに紐付いたtaskを作るのに必要
    # ログインしているUserクラスのインスタンスはcurrent_userというメソッドで取得できる
    # Userクラスのインスタンス.tasks.build構文が使える。
    # @task = Task.new
    # @task.user_id = current_user.id
    @task = current_user.tasks.build
  end
  
  def create
    # @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
    if @task.user != current_user
      redirect_to root_url
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.user != current_user
      redirect_to root_url
    end

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :new
    end

  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    if @task.user !=current_user
      redirect_to root_url
    end

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end

  private
  def set_task
    @task = Task.find_by(params[:id])
    if @task.user != current_user
      redirect_to root_url
    end
  end

  def task_params
    params.require(:task).permit(:content,:status)
  end
end
