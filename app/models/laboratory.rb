class Laboratory < ApplicationRecord
  has_secure_password
  belongs_to :user
  has_many :student_choice,    dependent: :destroy
  has_many :laboratory_choice, dependent: :destroy
  has_many :assign_list,       dependent: :destroy

  validates :loginid,
    presence: true,
    uniqueness: true,
    length: { maximum: 16 },
    format: {
      with: /\A[a-z0-9]+\z/,
      message: 'は小文字英数字を入力してください'
    }
  validates :password,
    presence: true,
    length: { minimum: 8 },
    on: :registration
  validates :laboratory_name,
    presence: true,
    length: { maximum: 30 }
  validates :name,
    presence: true,
    length: { maximum: 30 }
  validates :max_num,
    allow_blank: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0
      # greater_than: 0
    }

  def self.csv_import(csv_file, user_id)
    CSV.foreach(csv_file.path, headers: true) do |row|
      if row.length == 5
        laboratory = Laboratory.new(laboratory_params(row, user_id))
        unless laboratory.save
          return false, laboratory.errors.full_messages
        end
      else
        return false, ['カラム数が一致していません', '研究室は5カラムです']
      end
    end
    return true, nil
  end

  private

  def self.laboratory_params(row, user_id)
    laboratory_name = row[0].to_s
    name            = row[1].to_s
    max_num         = row[2].to_i
    loginid         = row[3].to_s
    password        = row[4].to_s
    laboratory_params = { 'user_id' => user_id, 'loginid' => loginid, 'password' => password,
                          'password_confirmation' => password, 'name' => name,
                          'laboratory_name' => laboratory_name, 'max_num' => max_num }
  end
end
