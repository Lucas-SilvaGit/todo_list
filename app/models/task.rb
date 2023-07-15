class Task < ApplicationRecord
  belongs_to :user

  validates :title, length: { maximum: 50 }, presence: true
  validates :body,length: { maximum: 100 }, presence: true
  validates :delivery_date, presence: true

  validate :check_reminder_validity, on: :update

  def check_reminder_validity
    if reminder? && delivery_date.past?
      errors.add(:reminder, "cannot be set for a task that is already overdue")
    end
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["body", "completed", "created_at", "delivery_date", "id", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
