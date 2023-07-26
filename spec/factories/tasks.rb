# spec/factories/tasks.rb
FactoryBot.define do
  factory :task do
    title { "Task Title" }
    body { "Task Body" }
    delivery_date { Date.today }
    completed { false }
    reminder { false }
    user { association :user }
  end
end