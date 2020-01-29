class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable, :trackable

  has_many :student,           dependent: :destroy
  has_many :laboratory,        dependent: :destroy
  has_many :assign_list,       dependent: :destroy
  has_many :student_choice,    dependent: :destroy
  has_many :laboratory_choice, dependent: :destroy

  validates :sap_key,
            presence: true,
            on: :init_setup
  validates :university_name,
            presence: true,
            length: { maximum: 30 },
            on: :init_setup
  validates :faculty_name,
            allow_blank: true,
            length: { maximum: 30 },
            on: :init_setup
  validates :department_name,
            allow_blank: true,
            length: { maximum: 30 },
            on: :init_setup
  validates :contact_email,
            allow_blank: true,
            format: {
              with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
              message: 'はEメールのフォーマットで入力してください'
            },
            on: :init_setup
  validates :max_choice_student,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1
            },
            on: :init_setup
  validates :max_choice_laboratory,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1
            },
            on: :init_setup
  validates :max_confirmed_student,
            allow_blank: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            },
            on: :init_setup
  validates :start_datetime,
            presence: true,
            on: :init_setup
  validates :end_datetime,
            presence: true,
            on: :init_setup
  validates :view_end_datetime,
            presence: true,
            on: :init_setup

  def self.generate_sap_key
    begin
      sap_key = SecureRandom.hex(6)
    end while self.exists?(sap_key: sap_key)
    return sap_key
  end
end
