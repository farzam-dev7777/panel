class TodoTasksController < BaseController

  before_filter :find_law_firm, only: [:create, :index]

  def create
    task = TodoTask.new(todo_task_params)
    if (task.save)
      head :ok
    end
  end

  private

  def find_law_firm
  	@law_firm = LawFirm.find_by(id: params[:law_firm_id])
  end

  def todo_task_params
    params.require(:todo_task).permit(:law_firm_id, :title, :message, :severity)
  end

end
