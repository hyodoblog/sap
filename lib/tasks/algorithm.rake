namespace :algorithm do
  require File.dirname(__FILE__) + '/../../app/controllers/concerns/algorithm.rb'
  include Algorithm
  desc "研究室配属アルゴリズムの実装"
  task :assign => :environment do
    Admin.all.each do |admin|

      # SAPが稼働しているかチェック
      unless admin.release_flag
        next
      end

      # 日付チェック
      now_datetime = Time.zone.now
      unless admin.start_datetime <= now_datetime && admin.end_datetime >= now_datetime
        next
      end

      # 学生と研究室が1つ以上あるかチェック
      if admin.student.length == 0 || admin.laboratory.length == 0
        next
      end

      algo_update(admin)
    end
  end
end