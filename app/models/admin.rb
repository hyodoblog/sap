class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable

  has_many :student,           dependent: :destroy
  has_many :laboratory,        dependent: :destroy
  has_many :assign_list,       dependent: :destroy
  has_many :student_choice,    dependent: :destroy
  has_many :laboratory_choice, dependent: :destroy
  has_many :student_rate,      dependent: :destroy
  has_many :laboratory_rate,   dependent: :destroy
  has_many :notice,            dependent: :destroy

  validates :sap_key,
            presence: true,
            on: :info
  validates :university_name,
            presence: true,
            length: { maximum: 30 },
            on: :info
  validates :faculty_name,
            allow_blank: true,
            length: { maximum: 30 },
            on: :info
  validates :department_name,
            allow_blank: true,
            length: { maximum: 30 },
            on: :info
  validates :contact_email,
            allow_blank: true,
            format: {
              with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
              message: 'はEメールのフォーマットで入力してください'
            },
            on: :info
  validates :max_choice_student,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1
            },
            on: :info
  validates :max_choice_laboratory,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1
            },
            on: :info
  validates :max_confirmed_student,
            allow_blank: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            },
            on: :info
  validates :start_datetime,
            presence: true,
            on: :info
  validates :end_datetime,
            presence: true,
            on: :info
  validates :view_end_datetime,
            presence: true,
            on: :info
  validate :password_complexity
  
  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,70}$/
    errors.add :password, "の強度が不足しています。パスワードの長さは8〜70文字とし、大文字、小文字、数字をそれぞれ1文字以上含める必要があります。"
  end

  def self.generate_sap_key
    begin
      sap_key = SecureRandom.hex(6)
    end while self.exists?(sap_key: sap_key)
    return sap_key
  end
end
