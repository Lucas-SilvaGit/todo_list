require 'rails_helper'

RSpec.describe Task, type: :model do

  describe "Task Creation" do
    it 'creates a new task' do
      user = create(:user)
      task = create(:task, user: user)

      expect(task.title).to eq('Task Title')
      expect(task.body).to  eq('Task Body')
      expect(task.delivery_date).to eq(Date.today)
      expect([true,false]).to include(task.completed)  
      expect([true, false]).to include(task.reminder) 
      expect(task.user).to eq(user) 
      expect(task).to be_valid  
    end

    it 'validates presence of title' do
      user = create(:user)
      task = build(:task, user: user, title: nil)
      expect(task.valid?).to be_falsey
      expect(task.errors[:title]).to include("can't be blank")  
    end

    it 'validates maximum length of title' do
      user = create(:user)
      task = build(:task, user: user, title: "a" * 51)
      expect(task.valid?).to be_falsey
      expect(task.errors[:title]).to include("is too long (maximum is 50 characters)")   
    end
  end
end
