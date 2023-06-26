class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :tasks, dependent: :destroy
         has_one_attached :avatar

  def full_name
    [self.first_name, self.last_name].join(' ')
  end
end
