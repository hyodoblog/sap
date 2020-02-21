class Notice < ApplicationRecord
  belongs_to :admin, optional: true

  validates :content,
            presence: true,
            length: { maximum: 100 }
end
