class Laboratory < ApplicationRecord
  has_secure_password
  belongs_to :user
  has_many :student_choice,    dependent: :destroy
  has_many :laboratory_choice, dependent: :destroy
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
  validates :laboratory_name,
    presence: true,
    length: { maximum: 30 }
  validates :name,
    presence: true,
    length: { maximum: 30 }
  validates :max_num,
    allow_blank: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0
      # greater_than: 0
    }
end
