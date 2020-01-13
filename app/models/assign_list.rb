class AssignList < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :laboratory, optional: true
  belongs_to :student, optional: true
end
