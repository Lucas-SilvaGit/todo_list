class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /tasks or /tasks.json
  def index
    @query = current_user.tasks.ransack(params[:q]) #retorna apenas as tarefas do usuário atual. aplica a pesquisa usando o Ransack
    @tasks = @query.result(distinct: true).page(params[:page]) #filtra os registros com base nos critérios de pesquisa do Ransack e do Kaminari para paginar os resultados para obter uma lista paginada de tarefas que correspondem aos critérios de pesquisa definidos pelo usuário.
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @task.delivery_date = Date.today
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /tasks/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        send_task_reminder_email(@task) if @task.reminder
        format.html { redirect_to root_path, notice: "Task was successfully created.", toastr: "success" }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        send_task_reminder_email(@task) if @task.reminder
        format.html { redirect_to root_path, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html do
          flash.now[:alert] = @task.errors.full_messages.join(", ")
          redirect_to root_path
        end
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed.", toastr: "success" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def send_task_reminder_email(task)
      return if task.completed?
      
      TaskMailer.task_reminder_email(task).deliver_now
    end    

    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :body, :delivery_date, :completed, :reminder)
    end
end
