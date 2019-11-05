class TasksController < ApplicationController
  before_action :set_id, only:[:show,:edit,:update,:destroy]
  before_action :login_check

  PER = 5

  def index
    if params[:sort_expired]
      @tasks = Task.sort_by_deadline.page(params[:page]).per(PER).my_task(current_user)
    elsif params[:sort_priority]
      @tasks =Task.sort_by_priority.page(params[:page]).per(PER).my_task(current_user)
    elsif params[:task]
      @tasks = Task.search(params[:task] ).sort_by_crated_at.page(params[:page]).per(PER).my_task(current_user)
    else
      @tasks = Task.sort_by_crated_at.page(params[:page]).per(PER).my_task(current_user)
    end
  end

  def new
    @task = Task.new
  end

  def show
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクを作成しました'
    else
      render 'new'
    end
  end

  def update
    if@task = current_user.tasks.build(task_params)
      redirect_to tasks_path, notice: 'タスクを編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました'
  end

  private

  def task_params
    params.require(:task).permit(:name, :detail, :deadline, :status, :priority)
  end

  def set_id
    @task = Task.find(params[:id])
  end

  def login_check
    unless logged_in?
      redirect_to new_session_path, notice: 'ログインしてください'
    end
  end

end
