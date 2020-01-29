class AssignList < ApplicationRecord
  belongs_to :admin,      optional: true
  belongs_to :student,    optional: true
  belongs_to :laboratory, optional: true
end
