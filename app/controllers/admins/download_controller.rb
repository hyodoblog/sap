class Admins::DownloadController < Admins::ApplicationController
  before_action :release_flag_true_check!

  def laboratory
    download_file_path = 'public/csv_template/laboratories.csv'
    send_file(download_file_path)
  end

  def student
    download_file_path = 'public/csv_template/students.csv'
    send_file(download_file_path)
  end
end
