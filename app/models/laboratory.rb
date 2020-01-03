class Laboratory < ApplicationRecord
  belongs_to :user
  has_many :student_choice,    dependent: :destroy
  has_many :laboratory_choice, dependent: :destroy
  has_many :assign_list,       dependent: :destroy

  validates :laboratory_name,
    presence: true,
    length: { maximum: 30 }
  validates :name,
    presence: true,
    length: { maximum: 30 }
  validates :max_num,
    allo_blank: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0
      # greater_than: 0
    }
end
