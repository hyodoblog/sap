class Student < ApplicationRecord
  has_secure_password
  belongs_to :user,              optional: true
  has_many   :laboratory_choice, dependent: :destroy
  has_many   :student_choice,    dependent: :destroy
  has_many   :assign_list,       dependent: :destroy

  validates :loginid,
            presence: true,
            uniqueness: {scope: [:user_id]},
            length: {maximum: 50},
            format: {
                with: /\A[-_@\.a-z0-9]+\z/,
                message: 'は小文字英数字またはEメールを入力してください'
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
  validates :email,
            allow_blank: true,
            uniqueness: true,
            length: {maximum: 50},
            format: {
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
              message: 'はEメールの形式で入力して下さい'
            },
            uniqueness: { case_sensitive: false }

  def self.csv_import(csv_file, user_id)
    Student.transaction do
      CSV.foreach(csv_file.path, headers: true) do |row|
        unless row.length == 5
          raise "カラム数が一致していません。学生は5カラムです"
        end

        Student.create!(
            user_id:               user_id,
            student_num:           row[0].to_s,
            name:                  row[1].to_s,
            email:                 row[2].to_s,
            loginid:               row[3].to_s,
            password:              row[4].to_s,
            password_confirmation: row[4].to_s,
            password_back:         row[4].to_s
        )
      end
    end
  end
end
