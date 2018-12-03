class Admin::TodoTasksController < Admin::BaseController

  def create
    
  end

  def new
    @todo_task = TodoTask.new
  end

  def filter_law_firms
    LawFirm
  end

  private

  def find_law_firm
  	@law_firm = LawFirm.find_by(id: params[:law_firm_id])
  end

  def todo_task_params
    params.require(:todo_task).permit(:law_firm_id, :title, :message, :severity)
  end

end
