class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_one :config,     dependent: :destroy
  has_one :student,    dependent: :destroy
  has_one :laboratory, dependent: :destroy
  accepts_nested_attributes_for :config, :student, :laboratory
end
