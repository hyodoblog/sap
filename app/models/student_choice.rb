class StudentChoice < ApplicationRecord
  belongs_to :student
  belongs_to :laboratory

  validates :rank,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0
    }
end
