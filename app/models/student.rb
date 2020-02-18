class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :lockable

  belongs_to :admin,             optional: true
  has_many   :student_choice,    dependent: :destroy
  has_many   :laboratory_choice, dependent: :destroy
  has_many   :assign_list,       dependent: :destroy
  has_many   :student_rate,      dependent: :destroy
  accepts_nested_attributes_for :student_choice,    allow_destroy: true
  accepts_nested_attributes_for :laboratory_choice, allow_destroy: true

  validates :email,
            presence: true,
            format: { with: Devise.email_regexp },
            on: :create
  validates :password,
            presence: true,
            confirmation: true,
            on: :create
  validates :name,
            presence: true,
            length: {maximum: 50}
  validates :student_num,
            presence: true,
            length: {maximum: 30}
  validate :password_complexity
  
  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,50}$/
    errors.add :password, "の強度が不足しています。パスワードの長さは8〜50文字とし、大文字、小文字、数字をそれぞれ1文字以上含める必要があります。"
  end

  def self.csv_import(csv_file, admin_id)
    Student.transaction do
      CSV.foreach(csv_file.path, headers: true) do |row|
        unless row.length == 4
          raise "カラム数が一致していません。学生は4カラムです"
        end

        Student.create!(
          admin_id:              admin_id,
          student_num:           row[0].floor.to_s,
          name:                  row[1].to_s,
          email:                 row[2].to_s,
          password:              row[3].to_s,
          password_confirmation: row[3].to_s,
          password_init:         row[3].to_s
        )
      end
    end
  end

  def self.xlsx_import(sheet, admin_id)
    index = 0
    Student.transaction do
      sheet.each do |row|
        index += 1
        next if index == 1
        Student.create(
          admin_id:              admin_id,
          student_num:           row[0].floor.to_s,
          name:                  row[1].to_s,
          email:                 row[2].to_s,
          password:              row[3].to_s,
          password_confirmation: row[3].to_s,
          password_init:         row[3].to_s
        )
      end
    end
  end
end
