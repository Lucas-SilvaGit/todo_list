class Task < ApplicationRecord
  belongs_to :user

  validates :title, :body, :delivery_date, presence: true
end
