namespace :date_check do
  desc "日付チェック"
  task :end_flag => :environment do
    Admin.all.each do |admin|
      next if admin.end_flag

      if admin.view_end_datetime <= Time.now()
        admin.update_attributes(end_flag: true)
      end
    end
  end
end
