class Student < ApplicationRecord
  belongs_to :user
  has_many :laboratory_choice, dependent: :destroy
  has_many :student_choice,    dependent: :destroy
  has_many :assign_list,       dependent: :destroy

  validates :name,
    presence: :true,
    length: { maximum: 50 }
  validates :student_num,
    presence: true,
    length: { maximum: 30 }
end
