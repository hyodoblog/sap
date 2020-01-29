class Laboratory < ApplicationRecord
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
            presence: true,
            length: { maximum: 50 }
  validates :professor_name,
            presence: true,
            length: { maximum: 50 }
  validates :max_num,
            allow_blank: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }
  validates :rate,
            allow_blank: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  def self.csv_import(csv_file, user_id)
    Laboratory.transaction do
      CSV.foreach(csv_file.path, headers: true) do |row|
        unless row.length == 5
          raise "カラム数が一致していません。研究室は5カラムです"
        end

        Laboratory.create!(
          user_id:               user_id,
          laboratory_name:       row[0].to_s,
          name:                  row[1].to_s,
          max_num:               row[2].nil? ? '' : row[2].to_i,
          email:                 row[3].to_s,
          password:              row[4].to_s,
          password_confirmation: row[4].to_s
        )
      end
    end
  end
end
