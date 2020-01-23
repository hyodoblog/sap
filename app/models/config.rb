class Config < ApplicationRecord
  belongs_to :user, optional: true

  validates :sap_key,
    presence: true
  validates :university_name,
    presence: true,
    length: { maximum: 30 }
  validates :faculty_name,
    allow_blank: true,
    length: { maximum: 30 }
  validates :department_name,
    allow_blank: true,
    length: { maximum: 30 }
  validates :contact_email,
    allow_blank: true,
    format: {
      with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
      message: 'はEメールのフォーマットで入力してください'
    }
  validates :max_choice_student,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0
    }
  validates :max_choice_laboratory,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0
    }
  validates :max_confirm_student,
    allow_blank: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0
    }
  validates :start_datetime,
    presence: true
  validates :end_datetime,
    presence: true
  validates :view_end_datetime,
    presence: true

  def self.generate_sap_key
    begin
      sap_key = SecureRandom.hex
    end while self.exists?(sap_key: sap_key)
    return sap_key
  end
end
