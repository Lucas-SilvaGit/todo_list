class Task < ApplicationRecord
  belongs_to :user

  validates :title, length: { maximum: 50 }, presence: true
  validates :body,length: { maximum: 100 }, presence: true
  validates :delivery_date, presence: true
  
  def self.ransackable_attributes(auth_object = nil)
    ["body", "completed", "created_at", "delivery_date", "id", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
