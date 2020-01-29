class LaboratoryChoice < ApplicationRecord
  belongs_to :admin,      optional: true
  belongs_to :laboratory, optional: true
  belongs_to :student,    optional: true

  validates :rank,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0
    }
end
