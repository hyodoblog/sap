# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ "name" => 'Star Wars' }, { "name" => 'Lord of the Rings' }])
#   Character.create("name" => 'Luke', movie: movies.first)

# テスト用のデータ

# 環境変数の初期化
test_email                    = ENV['TEST_EMAIL'].nil? ? 'example@example.com' : ENV['TEST_EMAIL'].to_s
password                      = ENV['TEST_PASSWORD'].nil? ? 'Pass1234' : ENV['TEST_PASSWORD'].to_s
number_of_student             = ENV['TEST_STUDENT_NUM'].nil? ? 7 : ENV['TEST_STUDENT_NUM'].to_i
number_of_laboratory          = ENV['TEST_LABORATORY_NUM'].nil? ? 3 : ENV['TEST_LABORATORY_NUM'].to_i
max_student_choice            = ENV['TEST_MAX_STUDENT_CHOICE'].nil? ? 7 : ENV['TEST_MAX_STUDENT_CHOICE'].to_i
max_laboratory_choice         = ENV['TEST_MAX_LABORATORY_CHOICE'].nil? ? 3 : ENV['TEST_MAX_LABORATORY_CHOICE'].to_i
student_choice_probability    = ENV['TEST_STUDNET_CHOICE_PROBABILITY'].nil? ? 3 : ENV['TEST_STUDNET_CHOICE_PROBABILITY'].to_i
laboratory_choice_probability = ENV['TEST_LABORATORY_CHOICE_PROBABILITY'].nil? ? 3 : ENV['TEST_LABORATORY_CHOICE_PROBABILITY'].to_i
max_conf_student              = ENV['TEST_CONF_STUDENT'].nil? ? 2 : ENV['TEST_CONF_STUDENT'].to_i
seed_num                      = ENV['TEST_SEED_NUM'].nil? ? 10 : ENV['TEST_SEED_NUM'].to_i

now_time = Time.now

# 乱数の設定
random = Random.new(seed_num)

# 管理者の初期設定
admin = Admin.find_by(email: test_email)
if admin.present?
  admin.destroy
end
Admin.create!(email:                 test_email,
              password:              password,
              confirmed_at:          now_time,
              sap_key:               'aaaa',
              university_name:       '九州工業大学',
              faculty_name:          '情報工学部',
              department_name:       '電子情報工学科',
              contact_email:         '',
              max_choice_student:    max_student_choice,
              max_choice_laboratory: max_laboratory_choice,
              max_confirmed_student: max_conf_student,
              start_datetime:        now_time,
              end_datetime:          now_time + 1.day,
              view_end_datetime:     now_time + 2.day,
              init_setup_flag:       true,
              release_flag:          true,
              start_flag:            true)
admin = Admin.find_by(email: test_email)
Student.where(admin_id: admin.id).destroy_all
Laboratory.where(admin_id: admin.id).destroy_all

# 学生の追加
students_params = []
for num in 1..number_of_student do
  begin
    name = 's_' + num.to_s
  end while Student.exists?(name: name)
  student_num = name
  email = name + '@example.com'
  student_param = { "password" => password, "password_confirmation" => password, "password_init" => password, "name" => name, "student_num" => student_num, "email" => email }
  admin.student.create!(student_param)
end

# 研究室の追加
laboratories_params = []
for num in 1..number_of_laboratory do
  begin
    professor_name = 'l_' + num.to_s
  end while Laboratory.exists?(professor_name: professor_name)
  name = professor_name + '研究室'
  email = professor_name + '@example.com'
  if num == 1 || random.rand(2) == 1
    max_num = ''
  else
    avarage = number_of_student / number_of_laboratory
    standard_num = avarage + 1
    max_num = random.rand(1..standard_num)
  end
  laboratory_param = { "password" => password, "password_confirmation" => password, "password_init" => password, "name" => name, "professor_name" => professor_name, "email" => email, "max_num" => max_num }
  admin.laboratory.create!(laboratory_param)
end

students = admin.student
laboratories = admin.laboratory

# 学生の希望提出
students.each do |student|
  next if random.rand(1..student_choice_probability) == 1
  choice_laboratories = laboratories[0..max_laboratory_choice]
  rank = 1
  choice_laboratories.each do |choice_laboratory|
    student.student_choice.create!(admin_id: admin.id, laboratory_id: choice_laboratory.id, rank: rank)
    rank += 1
  end
end

# 研究室の希望提出
laboratories.each do |laboratory|
  next if random.rand(1..laboratory_choice_probability) == 1
  choice_students = students[0..max_student_choice]
  rank = 1
  choice_students.each do |choice_student|
    laboratory.laboratory_choice.create!(admin_id: admin.id, student_id: choice_student.id, rank: rank)
    rank += 1
  end
end