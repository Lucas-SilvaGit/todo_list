class TaskMailer < ApplicationMailer
  def task_reminder_email(task)
    @task = task
    mail(to: task.user.email, subject: "Reminder: Task Due Soon: #{task.title}")
  end
end
