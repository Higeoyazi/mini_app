class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets ,dependent: :destroy
  has_many :comments ,dependent: :destroy

  validates :name, presence: true, length: { maximum: 15 }
  has_one_attached :avatar
end
