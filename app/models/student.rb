class Student < ApplicationRecord
  has_secure_password
  belongs_to :user, optional: true
  has_many :laboratory_choice, dependent: :destroy
  has_many :student_choice, dependent: :destroy
  has_many :assign_list, dependent: :destroy

  validates :loginid,
            presence: true,
            uniqueness: {scope: [:user_id]},
            length: {maximum: 16},
            format: {
                with: /\A[a-z0-9]+\z/,
                message: 'は小文字英数字を入力してください'
            }
  validates :password,
            presence: true,
            length: {minimum: 8},
            on: :registration
  validates :name,
            presence: :true,
            length: {maximum: 50}
  validates :student_num,
            presence: true,
            length: {maximum: 30}

  def self.csv_import(csv_file, user_id)
    Student.transaction do
      CSV.foreach(csv_file.path, headers: true) do |row|
        unless row.length == 4
          raise "カラム数が一致していません。学生は4カラムです"
        end

        Student.create!(
            user_id: user_id, loginid: row[2].to_s, password: row[3].to_s,
            password_confirmation: row[3].to_s, name: row[1].to_s,
            student_num: row[0].to_s
        )
      end
    end
  end
end
