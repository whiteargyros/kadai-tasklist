class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    redirect_back(fallback_location: root_path)
#    @tasks = Task.order(:id).page(params[:page])
  end

  def show
    if 
      current_user != @task.user
      redirect_back(fallback_location: root_path)
    end
  end

  def new
    redirect_back(fallback_location: root_path)
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Task posted successfully'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'Task posted failed'
      render 'toppages/index'
    end
  end

  def edit
    if 
      current_user != @task.user
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'Task updated successfully'
      redirect_to root_path
    else
      flash.now[:danger] = 'Task update failed'
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'Task destroyed'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
