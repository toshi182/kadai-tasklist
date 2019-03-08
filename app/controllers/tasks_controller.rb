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
    @tasks = Task.find(params[:id])
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
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :new
    end

  end

  def destroy
    @tasks = Task.find(params[:id])
    @tasks.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end

  private
  def set_task
    @tasks = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content,:status)
  end
end
