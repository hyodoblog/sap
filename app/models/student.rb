class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, invite_for: 24.hours

  belongs_to :admin,             optional: true
  has_many   :student_choice,    dependent: :destroy
  has_many   :laboratory_choice, dependent: :destroy
  has_many   :assign_list,       dependent: :destroy
  accepts_nested_attributes_for :student_choice,    allow_destroy: true
  accepts_nested_attributes_for :laboratory_choice, allow_destroy: true

  validates :name,
            presence: :true,
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

  def self.csv_import(csv_file, user_id)
    Student.transaction do
      CSV.foreach(csv_file.path, headers: true) do |row|
        unless row.length == 4
          raise "カラム数が一致していません。学生は4カラムです"
        end

        Student.create!(
          user_id:               user_id,
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
