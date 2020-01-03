class Student < ApplicationRecord
  has_secure_password
  belongs_to :user
  has_many :laboratory_choice, dependent: :destroy
  has_many :student_choice,    dependent: :destroy
  has_many :assign_list,       dependent: :destroy

  validates :loginid,
    presence: true,
    uniqueness: true,
    length: { maximum: 16 },
    format: {
      with: /\A[a-z0-9]+\z/,
      message: 'は小文字英数字を入力してください'
    }
  validates :password,
    presence: true,
    length: { minimum: 8 },
    on: :registration
  validates :name,
    presence: :true,
    length: { maximum: 50 }
  validates :student_num,
    presence: true,
    length: { maximum: 30 }
end
