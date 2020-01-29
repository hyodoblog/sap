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

Admin.create(email:        test_email,
            password:     'password',
            confirmed_at: now_time)

# Config.create(user_id:               user_id,
#               sap_key:               'aaaaaa',
#               university_name:       '九州工業大学',
#               faculty_name:          '情報工学科',
#               department_name:       '電子情報工学科',
#               contact_email:         '',
#               max_choice_student:    4,
#               max_choice_laboratory: 3,
#               max_confirm_student:   '',
#               start_datetime:        now_time,
#               end_datetime:          now_time + 1.day,
#               view_end_datetime:     now_time + 2.day)

# laboratories_params = [
#   { "user_id" => user_id, "loginid" => "aaaa", "password" => "aaaaaaaa", "password_confirmation" => "aaaaaaaa", "password_back" => "aaaaaaaa", "name" => 'A', "laboratory_name" => 'A研究室', "email" => 'aaaa@example.com', "max_num" => '3', "rate" => '' },
#   { "user_id" => user_id, "loginid" => "bbbb", "password" => "bbbbbbbb", "password_confirmation" => "bbbbbbbb", "password_back" => "bbbbbbbb", "name" => 'B', "laboratory_name" => 'B研究室', "email" => 'bbbb@example.com', "max_num" => '2', "rate" => '' },
#   { "user_id" => user_id, "loginid" => "cccc", "password" => "cccccccc", "password_confirmation" => "cccccccc", "password_back" => "cccccccc", "name" => 'C', "laboratory_name" => 'C研究室', "email" => 'cccc@example.com', "max_num" => '',  "rate" => '' }
# ]

# laboratories_params.each do |param|
#   Laboratory.new(param).save()
# end

# students_params = [
#   { "user_id" => user_id, "loginid" => "1111", "password" => "11111111", "password_confirmation" => "11111111", "password_back" => "11111111", "name" => 'D', "student_num" => 12340001, "email" => 'd12340001@example.com', "rate" => '' },
#   { "user_id" => user_id, "loginid" => "2222", "password" => "22222222", "password_confirmation" => "22222222", "password_back" => "22222222", "name" => 'E', "student_num" => 12340002, "email" => 'e12340002@example.com', "rate" => '' },
#   { "user_id" => user_id, "loginid" => "3333", "password" => "33333333", "password_confirmation" => "33333333", "password_back" => "33333333", "name" => 'F', "student_num" => 12340003, "email" => 'f12340003@example.com', "rate" => '' },
#   { "user_id" => user_id, "loginid" => "4444", "password" => "44444444", "password_confirmation" => "44444444", "password_back" => "44444444", "name" => 'G', "student_num" => 12340004, "email" => 'g12340004@example.com', "rate" => '' },
#   { "user_id" => user_id, "loginid" => "5555", "password" => "55555555", "password_confirmation" => "55555555", "password_back" => "55555555", "name" => 'H', "student_num" => 12340005, "email" => 'h12340005@example.com', "rate" => '' },
#   { "user_id" => user_id, "loginid" => "6666", "password" => "66666666", "password_confirmation" => "66666666", "password_back" => "66666666", "name" => 'I', "student_num" => 12340006, "email" => 'i12340006@example.com', "rate" => '' },
#   { "user_id" => user_id, "loginid" => "7777", "password" => "77777777", "password_confirmation" => "77777777", "password_back" => "77777777", "name" => 'J', "student_num" => 12340007, "email" => 'j12340007@example.com', "rate" => '' }
# ]

# students_params.each do |param|
#   Student.create(param)
# end

# laboratories_choice_params = [
#   { "laboratory_id" => 1, "student_id" => 7, "rank" => 1 },
#   { "laboratory_id" => 1, "student_id" => 2, "rank" => 2 },
#   { "laboratory_id" => 1, "student_id" => 5, "rank" => 3 },
#   { "laboratory_id" => 1, "student_id" => 4, "rank" => 4 },
#   { "laboratory_id" => 2, "student_id" => 6, "rank" => 1 },
#   { "laboratory_id" => 2, "student_id" => 2, "rank" => 2 },
#   { "laboratory_id" => 2, "student_id" => 7, "rank" => 3 },
#   { "laboratory_id" => 2, "student_id" => 1, "rank" => 4 },
#   { "laboratory_id" => 3, "student_id" => 2, "rank" => 1 },
#   { "laboratory_id" => 3, "student_id" => 5, "rank" => 2 },
#   { "laboratory_id" => 3, "student_id" => 6, "rank" => 3 },
#   { "laboratory_id" => 3, "student_id" => 4, "rank" => 4 }
# ]

# # laboratories_choice_params = [
# #   { "laboratory_id" => 1, "student_id" => 7, "rank" => 1 },
# #   { "laboratory_id" => 1, "student_id" => 2, "rank" => 2 },
# #   { "laboratory_id" => 1, "student_id" => 5, "rank" => 3 },
# #   { "laboratory_id" => 1, "student_id" => 4, "rank" => 4 },
# #   { "laboratory_id" => 2, "student_id" => 6, "rank" => 1 },
# #   { "laboratory_id" => 2, "student_id" => 2, "rank" => 2 },
# #   { "laboratory_id" => 2, "student_id" => 7, "rank" => 3 },
# #   { "laboratory_id" => 2, "student_id" => 1, "rank" => 4 },
# #   { "laboratory_id" => 3, "student_id" => 2, "rank" => 1 },
# #   { "laboratory_id" => 3, "student_id" => 5, "rank" => 2 },
# #   { "laboratory_id" => 3, "student_id" => 6, "rank" => 3 },
# #   { "laboratory_id" => 3, "student_id" => 4, "rank" => 4 }
# # ]

# laboratories_choice_params.each do |param|
#   LaboratoryChoice.create(param)
# end

# students_choice_params = [
#   { "student_id" => 1, "laboratory_id" => 1, "rank" => 1 },
#   { "student_id" => 1, "laboratory_id" => 2, "rank" => 2 },
#   { "student_id" => 1, "laboratory_id" => 3, "rank" => 3 },
#   { "student_id" => 2, "laboratory_id" => 1, "rank" => 1 },
#   { "student_id" => 2, "laboratory_id" => 2, "rank" => 2 },
#   { "student_id" => 2, "laboratory_id" => 3, "rank" => 3 },
#   { "student_id" => 4, "laboratory_id" => 1, "rank" => 1 },
#   { "student_id" => 4, "laboratory_id" => 2, "rank" => 2 },
#   { "student_id" => 4, "laboratory_id" => 3, "rank" => 3 },
#   { "student_id" => 5, "laboratory_id" => 1, "rank" => 1 },
#   { "student_id" => 5, "laboratory_id" => 2, "rank" => 2 },
#   { "student_id" => 5, "laboratory_id" => 3, "rank" => 3 },
#   { "student_id" => 6, "laboratory_id" => 1, "rank" => 1 },
#   { "student_id" => 6, "laboratory_id" => 2, "rank" => 2 },
#   { "student_id" => 6, "laboratory_id" => 3, "rank" => 3 },
#   { "student_id" => 7, "laboratory_id" => 1, "rank" => 1 },
#   { "student_id" => 7, "laboratory_id" => 2, "rank" => 2 },
#   { "student_id" => 7, "laboratory_id" => 3, "rank" => 3 }
# ]

# # students_choice_params = [
# #   { "student_id" => 1, "laboratory_id" => 1, "rank" => 1 },
# #   { "student_id" => 1, "laboratory_id" => 2, "rank" => 2 },
# #   { "student_id" => 1, "laboratory_id" => 3, "rank" => 3 },
# #   { "student_id" => 2, "laboratory_id" => 3, "rank" => 1 },
# #   { "student_id" => 2, "laboratory_id" => 1, "rank" => 2 },
# #   { "student_id" => 2, "laboratory_id" => 2, "rank" => 3 },
# #   { "student_id" => 4, "laboratory_id" => 2, "rank" => 1 },
# #   { "student_id" => 4, "laboratory_id" => 3, "rank" => 2 },
# #   { "student_id" => 4, "laboratory_id" => 1, "rank" => 3 },
# #   { "student_id" => 5, "laboratory_id" => 1, "rank" => 1 },
# #   { "student_id" => 5, "laboratory_id" => 3, "rank" => 2 },
# #   { "student_id" => 5, "laboratory_id" => 2, "rank" => 3 },
# #   { "student_id" => 6, "laboratory_id" => 1, "rank" => 1 },
# #   { "student_id" => 6, "laboratory_id" => 2, "rank" => 2 },
# #   { "student_id" => 6, "laboratory_id" => 3, "rank" => 3 },
# #   { "student_id" => 7, "laboratory_id" => 1, "rank" => 1 },
# #   { "student_id" => 7, "laboratory_id" => 3, "rank" => 2 },
# #   { "student_id" => 7, "laboratory_id" => 2, "rank" => 3 }
# # ]

# students_choice_params.each do |param|
#   StudentChoice.create(param)
# end