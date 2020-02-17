class Admins::DownloadController < Admins::ApplicationController
  def laboratory
    download_file_path = 'public/template_file/laboratories.csv'
    send_file(download_file_path)
  end

  def student
    download_file_path = 'public/template_file/students.csv'
    send_file(download_file_path)
  end

  def excel
    download_file_path = 'public/template_file/sap_excel_template.xlsx'
    send_file(download_file_path)
  end
end
