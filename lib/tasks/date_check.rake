namespace :date_check do
  desc "end_flagの更新"
  task :end_flag => :environment do
    Admin.all.each do |admin|
      next if admin.end_flag

      if admin.view_end_datetime.present && admin.view_end_datetime <= Time.now()
        puts("Update end_flag: #{admin.university_name} #{admin.faculty_name} #{admin.department_name}")
        admin.update_attributes(init_setup_flag: true, release_flag: true, start_flag: true, end_flag: true)

        eval_cal(admin)
      end
    end
  end

  desc 'アカウント初期化'
  task :account_init => :environment do
    Admin.all.each do |admin|
      next unless admin.end_flag

      now_time = Time.now()
      delete_datetime = admin.view_end_datetime + 14.days
      if delete_datetime <= now_time
        puts("Initialize account: #{admin.university_name} #{admin.faculty_name} #{admin.department_name}")
        admin.student.destroy_all
        admin.laboratory.destroy_all
        admin.update_attributes(admin_init_params)
      end
    end
  end

  private

  def admin_init_params
    now_datetime = DateTime.now
    {
        sap_key: Admin.generate_sap_key, university_name: '〇〇大学',
        faculty_name: '', department_name: '', contact_email: '',
        max_choice_student: 1, max_choice_laboratory: 1,
        start_datetime: now_datetime, end_datetime: now_datetime + 1.days, view_end_datetime: now_datetime + 2.days,
        init_setup_flag: false, release_flag: false, start_flag: false, end_flag: false,
        end_notice_flag: false, view_end_notice_flag: false
    }
  end

  def eval_cal(admin)
    point = 0

    admin.assign_list.each do |assign_list|
      begin
        rank = admin.student.find_by(id: assign_list.student_id).student_choice.find_by(laboratory_id: assign_list.laboratory_id).rank
      rescue NoMethodError
        rank = 0
      end

      case rank
      when 0 then
        point += 0
      when 1 then
        point += 3
      when 2 then
        point += 2
      when 3 then
        point += 1
      else
        point -= 1
      end

    end

    admin.point = point
    admin.save()
  end
end

# 学生の希望順位を取得