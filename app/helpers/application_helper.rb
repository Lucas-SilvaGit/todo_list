module ApplicationHelper
  def task_status_class(task)
    if task.completed
      return "completed"
    elsif task.delivery_date < Date.today
      return "overdue"
    elsif task.delivery_date > Date.today + 1
      return "upcoming"
    else
      return "normal"
    end
  end
end
