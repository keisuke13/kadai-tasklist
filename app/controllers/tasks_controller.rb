class TasksController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが登録されませんでした'
      render :new
    end
  end  
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'Taskは正常に更新されました'
      redirect_to @task
    else
      flash[:danger] = 'Taskは正常に更新されませんでした'
      render :edit
    end
  end  
  
  def destroy
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end

  private 
  #Strong Parameter
  
  def set_message
    @task =Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:status,:content)
  end
end
