require 'rails_helper'

RSpec.describe Task, type: :model do

  describe "Creation" do
    context "when data is valid" do
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
    end
  
    context "when data is invalid" do
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

      it 'validates presence of body' do
        user = create(:user)
        task = build(:task, user: user, body: nil)
        expect(task.valid?).to be_falsey
        expect(task.errors[:body]).to include("can't be blank")
      end

      it 'validates maximum length of body' do
        user = create(:user)
        task = build(:task, user: user, body: "a" * 101)
        expect(task.valid?).to be_falsey  
        expect(task.errors[:body]).to include("is too long (maximum is 100 characters)")
      end

      it 'validates presence of delivery date' do
        user = create(:user)
        task = build(:task, user: user, delivery_date: nil)
        expect(task.valid?).to be_falsey
        expect(task.errors[:delivery_date]).to include("can't be blank")
      end

      it 'validates delivery date invalid' do
        user = create(:user)
        task = build(:task, user: user, delivery_date: Date.yesterday)
        expect(task).not_to be_valid  
        expect(task.errors[:delivery_date]).to include("must be a future date")
      end

      it 'validates delivery date future with reminder on ' do
        user = create(:user)
        future_delivery_date = Date.tomorrow
        task = build(:task, user: user, delivery_date: future_delivery_date, reminder: true)

        expect(task).to be_valid
        expect(task.errors[:reminder]).not_to include("cannot be set for a task that is already overdue")
      end

      it 'validates delive date past with reminder on' do
        user = create(:user)
        task = build(:task, user: user, delivery_date: Date.yesterday, reminder: true)
      
        expect(task).not_to be_valid
        expect(task.errors[:delivery_date]).to include("must be a future date")
      end      
    end
  end

  describe "Associations" do
    context "with ransack" do
      it 'vaidates that the task is associated with a valid user' do
        task = build(:task, user: nil)

        expect(task).not_to be_valid
        expect(task.errors[:user]).to include("must exist")
      end
    end
    
    context "ransackable attributes" do
      it "returns the correct list of attributes for ransack" do
        expected_attributes = ["body", "completed", "created_at", "delivery_date", "id", "title", "updated_at", "user_id"]
        expect(Task.ransackable_attributes).to match_array(expected_attributes)
      end

      it 'returns the correct list of associations for ransack' do
        expected_associations = ["user"]
        expect(Task.ransackable_associations).to match_array(expected_associations)  
      end
    end
  end
end
