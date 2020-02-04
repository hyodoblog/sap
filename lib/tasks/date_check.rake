namespace :date_check do
  desc "end_flagの更新"
  task :end_flag => :environment do
    Admin.all.each do |admin|
      next if admin.end_flag

      if admin.view_end_datetime <= Time.now()
        puts("Update end_flag: #{admin.university_name admin.faculty_name admin.department_name}")
        admin.update_attributes(end_flag: true)
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
        puts("Initialize account: #{admin.university_name admin.faculty_name admin.department_name}")
        admin.student.destroy_all
        admin.laboratory.destroy_all
      end
    end
  end
end
