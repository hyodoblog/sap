class Config < ApplicationRecord
  belongs_to :user

  validates :sap_key,
    presence: true
  validates :university_name,
    presence: true,
    length: { maximum: 30 }
  validates :faculty_name,
    length: { maximum: 30 }
  validates :department_name,
    length: { maximum: 30 }
  validates :contact_email,
    format: {
      with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
      message: 'はメールアドレスのフォーマットで入力してください'
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
