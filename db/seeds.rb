# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ "name" => 'Star Wars' }, { "name" => 'Lord of the Rings' }])
#   Character.create("name" => 'Luke', movie: movies.first)

# テスト用のデータ
# 必ずデータベースをリセットしてから実行して下さい
# 直接idを指定しているため
# ---- コマンド ----
# docker-compose exec app bundle exec rails db:migrate:reset && docker-compose exec app bundle exec rails db:seed

test_email = ENV['DEVELOPMENT_EMAIL'] ||= 'example@example.com'
now_time = Time.now

User.create(email:        test_email,
            password:     'password',
            confirmed_at: now_time)

user_id = User.find_by("email" => test_email).id

Config.create(user_id:               user_id,
              sap_key:               'aaaaaa',
              university_name:       '九州工業大学',
              faculty_name:          '情報工学科',
              department_name:       '電子情報工学科',
              contact_email:         '',
              max_choice_student:    4,
              max_choice_laboratory: 3,
              max_confirm_student:   2,
              start_datetime:        now_time,
              end_datetime:          now_time + 1.day,
              view_end_datetime:     now_time + 2.day)

laboratories_params = [
  { "user_id" => user_id, "name" => 'A', "laboratory_name" => 'A研究室', "email" => 'aaaa@example.com', "max_num" => '3', "rate" => '' },
  { "user_id" => user_id, "name" => 'B', "laboratory_name" => 'B研究室', "email" => 'bbbb@example.com', "max_num" => '2', "rate" => '' },
  { "user_id" => user_id, "name" => 'C', "laboratory_name" => 'C研究室', "email" => 'cccc@example.com', "max_num" => '',  "rate" => '' }
]

Laboratory.new(laboratories_params).save()

students_params = [
  { "user_id" => user_id, "name" => 'D', "student_num" => 12340001, "email" => 'd12340001@example.com', "rate" => '' },
  { "user_id" => user_id, "name" => 'E', "student_num" => 12340002, "email" => 'e12340002@example.com', "rate" => '' },
  { "user_id" => user_id, "name" => 'F', "student_num" => 12340003, "email" => 'f12340003@example.com', "rate" => '' },
  { "user_id" => user_id, "name" => 'G', "student_num" => 12340004, "email" => 'g12340004@example.com', "rate" => '' },
  { "user_id" => user_id, "name" => 'H', "student_num" => 12340005, "email" => 'h12340005@example.com', "rate" => '' },
  { "user_id" => user_id, "name" => 'I', "student_num" => 12340006, "email" => 'i12340006@example.com', "rate" => '' },
  { "user_id" => user_id, "name" => 'J', "student_num" => 12340007, "email" => 'j12340007@example.com', "rate" => '' }
]

Student.new(students_params).save()

laboratories_choice_params = [
  { "laboratory_id" => 1, "student_id" => 7, "rank" => 1 },
  { "laboratory_id" => 1, "student_id" => 2, "rank" => 2 },
  { "laboratory_id" => 1, "student_id" => 5, "rank" => 3 },
  { "laboratory_id" => 1, "student_id" => 4, "rank" => 4 },
  { "laboratory_id" => 2, "student_id" => 6, "rank" => 1 },
  { "laboratory_id" => 2, "student_id" => 2, "rank" => 2 },
  { "laboratory_id" => 2, "student_id" => 7, "rank" => 3 },
  { "laboratory_id" => 2, "student_id" => 1, "rank" => 4 },
  { "laboratory_id" => 3, "student_id" => 2, "rank" => 1 },
  { "laboratory_id" => 3, "student_id" => 5, "rank" => 2 },
  { "laboratory_id" => 3, "student_id" => 6, "rank" => 3 },
  { "laboratory_id" => 3, "student_id" => 4, "rank" => 4 }
]

LaboratoryChoice.new(laboratories_choice_params).save()

students_choice_params = [
  { "student_id" => 1, "laboratory_id" => 1, "rank" => 1 },
  { "student_id" => 1, "laboratory_id" => 2, "rank" => 2 },
  { "student_id" => 1, "laboratory_id" => 3, "rank" => 3 },
  { "student_id" => 2, "laboratory_id" => 3, "rank" => 1 },
  { "student_id" => 2, "laboratory_id" => 1, "rank" => 2 },
  { "student_id" => 2, "laboratory_id" => 2, "rank" => 3 },
  { "student_id" => 4, "laboratory_id" => 2, "rank" => 1 },
  { "student_id" => 4, "laboratory_id" => 3, "rank" => 2 },
  { "student_id" => 4, "laboratory_id" => 1, "rank" => 3 },
  { "student_id" => 5, "laboratory_id" => 1, "rank" => 1 },
  { "student_id" => 5, "laboratory_id" => 3, "rank" => 2 },
  { "student_id" => 5, "laboratory_id" => 2, "rank" => 3 },
  { "student_id" => 6, "laboratory_id" => 1, "rank" => 1 },
  { "student_id" => 6, "laboratory_id" => 2, "rank" => 2 },
  { "student_id" => 6, "laboratory_id" => 3, "rank" => 3 },
  { "student_id" => 7, "laboratory_id" => 1, "rank" => 1 },
  { "student_id" => 7, "laboratory_id" => 3, "rank" => 2 },
  { "student_id" => 7, "laboratory_id" => 2, "rank" => 3 }
]

StudentChoice.new(students_choice_params).create()