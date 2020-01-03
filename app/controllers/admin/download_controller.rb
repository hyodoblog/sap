class Admin::DownloadController < ApplicationController
  def laboratory
    download_file_path = 'public/csv_template/laboratory.csv'
    send_file download_file_path
  end

  def student
    download_file_path = 'public/csv_template/student.csv'
    send_file download_file_path
  end
end
