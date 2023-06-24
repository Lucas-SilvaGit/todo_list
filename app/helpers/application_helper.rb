module ApplicationHelper
  def task_status_class(task)
    if task.completed
      return "border border-1 border-success"
    elsif task.delivery_date < Date.today
      return "border border-1 border-danger"
    elsif task.delivery_date > Date.today + 1
      return "border border-1 border-primary"
    else
      return "border border-1 border-warning"
    end
  end
end
