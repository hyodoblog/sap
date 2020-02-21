class Notice < ApplicationRecord
  belongs_to :admin, optional: true

  validates :content,
            presence: true,
            length: { maximum: 150 }
end
