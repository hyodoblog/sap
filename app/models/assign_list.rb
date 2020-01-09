class AssignList < ApplicationRecord
  belongs_to :user
  belongs_to :laboratory
  belongs_to :student
end
