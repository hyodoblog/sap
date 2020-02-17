class StudentRate < ApplicationRecord
  belongs_to :admin,   optional: true
  belongs_to :student, optional: true

  validates :rate,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0
    }
end
