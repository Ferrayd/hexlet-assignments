class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    puts "Создаваемая задача: #{@task.inspect}"
  
    if @task.save
      redirect_to @task, notice: 'Задача успешно создана.'
    else
      puts "Ошибка создания: #{@task.errors.full_messages}"
      render :new, status: :unprocessable_entity
    end
  end
  

  def edit; end

  def update
    puts "Обновляем задачу: #{@task.inspect}"
    puts "Переданные параметры: #{task_params.inspect}"

    if @task.update(task_params)
      redirect_to @task, notice: 'Задача обновлена'
    else
      puts "Ошибка обновления: #{@task.errors.full_messages}"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Задача удалена.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :status, :creator, :performer, :completed)
  end
end
