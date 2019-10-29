class TasksController < ApplicationController
  before_action :set_id, only:[:show,:edit,:update,:destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.sort_by_deadline
    else
      @tasks = Task.sort_by_crated_at
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
    @task =  Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクを作成しました'
    else
      render 'new'
    end
  end

  def update
    if @task.update(task_params)
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
    params.require(:task).permit(:name, :detail, :deadline, :status)
  end

  def set_id
    @task = Task.find(params[:id])
  end
end
