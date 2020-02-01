class Student < ApplicationRecord
  belongs_to :admin,             optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many   :student_choice,    dependent: :destroy
  has_many   :laboratory_choice, dependent: :destroy
  has_many   :assign_list,       dependent: :destroy
  accepts_nested_attributes_for :student_choice,    allow_destroy: true
  accepts_nested_attributes_for :laboratory_choice, allow_destroy: true

  validates :email,
            presence: true,
            format: { with: Devise.email_regexp },
            uniqueness: { scope: :admin_id }
  validates :password,
            presence: true,
            length: { within: Devise.password_length }
  validates :name,
            presence: true,
            length: {maximum: 50}
  validates :student_num,
            presence: true,
            length: {maximum: 30}
  validates :rate,
            allow_blank: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }
  validate :password_complexity
  
  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,70}$/
    errors.add :password, "の強度が不足しています。パスワードの長さは8〜70文字とし、大文字、小文字、数字をそれぞれ1文字以上含める必要があります。"
  end

  def self.csv_import(csv_file, admin_id)
    Student.transaction do
      CSV.foreach(csv_file.path, headers: true) do |row|
        unless row.length == 4
          raise "カラム数が一致していません。学生は4カラムです"
        end

        Student.create!(
          admin_id:              admin_id,
          student_num:           row[0].to_s,
          name:                  row[1].to_s,
          email:                 row[2].to_s,
          password:              row[3].to_s,
          password_confirmation: row[3].to_s
        )
      end
    end
  end
end
