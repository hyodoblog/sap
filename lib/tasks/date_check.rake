namespace :date_check do
  desc "end_flagの更新"
  task :end_flag => :environment do
    Admin.all.each do |admin|
      next if admin.end_flag

      if admin.view_end_datetime <= Time.now()
        puts("Update end_flag: #{admin.university_name} #{admin.faculty_name} #{admin.department_name}")
        admin.update_attributes(init_setup_flag: true, start_flag: true, end_flag: true)
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
end
