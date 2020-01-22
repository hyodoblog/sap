class Laboratory < ApplicationRecord
  has_secure_password
  belongs_to :user, optional: true
  has_many :student_choice, dependent: :destroy
  has_many :laboratory_choice, dependent: :destroy
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
  validates :laboratory_name,
            presence: true,
            length: {maximum: 30}
  validates :name,
            presence: true,
            length: {maximum: 30}
  validates :max_num,
            allow_blank: true,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0
                # greater_than: 0
            }

  def self.csv_import(csv_file, user_id)
    Laboratory.transaction do
      CSV.foreach(csv_file.path, headers: true) do |row|
        unless row.length == 5
          raise "カラム数が一致していません。研究室は5カラムです"
        end

        Laboratory.create!(
            user_id: user_id, laboratory_name: row[0].to_s, name: row[1].to_s, max_num: row[2].to_i,
            loginid: row[3].to_s, password: row[4].to_s, password_confirmation: row[4].to_s
        )
      end
    end
  end
end
