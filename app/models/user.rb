class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable, :trackable

  has_one  :config,      dependent: :destroy
  has_many :assign_list, dependent: :destroy
  has_many :student,     dependent: :destroy
  has_many :laboratory,  dependent: :destroy
end
