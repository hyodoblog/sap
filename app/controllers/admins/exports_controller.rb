class Admins::ExportsController < Admins::ApplicationController
  skip_before_action :release_true_check!
  skip_before_action :end_check!
  before_action      :release_false_check!

  def index
    respond_to do |format|
      format.xlsx do
        generate_xlsx
      end
    end
    flash[:notice] = '最終結果をエクセルファイルで送信しました'
    redirect_to(admins_root_path)
  end

  private

  def generate_xlsx
    assign_list = assign_list_make
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(name: '配属結果') do |sheet|
        sheet.add_row %w(研究室 学生)
        assign_list.each do |laboratory_name, assign_student_array|
          sheet.add_row do |row|
            row.add_cell(laboratory_name)
            assign_list_cell = ''
            assign_student_array.each do |student_name|
              assign_list_cell += ', ' unless assign_list_cell.empty?
              assign_list_cell += student_name
            end
            row.add_cell(assign_list_cell)
          end
        end
      end
      p.workbook.add_worksheet(name: '管理者情報') do |sheet|
        sheet.add_row %w(Eメール 大学名 学部 学科 連絡先メール 最大学生希望人数 最大研究室希望数 希望提出開始日 希望提出終了日 閲覧終了日)
        sheet.add_row do |row|
          row.add_cell(current_admin.email)
          row.add_cell(current_admin.university_name)
          row.add_cell(current_admin.faculty_name)
          row.add_cell(current_admin.department_name)
          row.add_cell(current_admin.contact_email)
          row.add_cell(current_admin.max_choice_student)
          row.add_cell(current_admin.max_choice_laboratory)
          row.add_cell(current_admin.start_datetime.to_s(:datetime_jp))
          row.add_cell(current_admin.end_datetime.to_s(:datetime_jp))
          row.add_cell(current_admin.view_end_datetime.to_s(:datetime_jp))
        end
      end
      p.workbook.add_worksheet(name: '学生情報') do |sheet|
        sheet.add_row %w(学籍番号 名前 Eメール 希望研究室リスト)
        current_admin.student.each do |student|
          sheet.add_row do |row|
            row.add_cell(student.student_num)
            row.add_cell(student.name)
            row.add_cell(student.email)
            student_choice_laboratory_cell = ''
            student.student_choice.each do |choice_laboratory|
              student_choice_laboratory_cell += ', ' unless student_choice_laboratory_cell.empty?
              student_choice_laboratory_cell += choice_laboratory.laboratory.name
            end
            row.add_cell(student_choice_laboratory_cell)
          end
        end
      end
      p.workbook.add_worksheet(name: '研究室情報') do |sheet|
        sheet.add_row %w(研究室名 名前 最大配属人数 Eメール 希望学生リスト)
        current_admin.laboratory.each do |laboratory|
          sheet.add_row do |row|
            row.add_cell(laboratory.name)
            row.add_cell(laboratory.professor_name)
            row.add_cell(laboratory.max_num)
            row.add_cell(laboratory.email)
            laboratory_choice_student_cell = ''
            laboratory.laboratory_choice.each do |choice_student|
              laboratory_choice_student_cell += ', ' unless !laboratory_choice_student_cell.empty?
              laboratory_choice_student_cell += choice_student.student.name
            end
            row.add_cell(laboratory_choice_student_cell)
          end
        end
      end
      # if current_admin.student_rate.present?
      #   p.workbook.add_worksheet(name: '学生レート情報') do |sheet|
      #     student_rate_list_make.each do |row|
      #       sheet.add_row row
      #     end
      #   end
      # end
      # if current_admin.laboratory_rate.present?
      #   p.workbook.add_worksheet(name: '研究室レート情報') do |sheet|
      #     list = 
      #     sheet.add_row laboratory_rate_row_name
      #     current_admin.laboratory.each do |laboratory|
      #       sheet.add_row laboratory_rate_row(laboratory)
      #     end
      #   end
      # end
      send_data(p.to_stream.read,
                type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                filename: "sap.xlsx")
    end
  end

  def assign_list_make
    laboratories = current_admin.laboratory.order(id: 'ASC')
    assign_list = {}

    laboratories.each do |laboratory|
      assigns = current_admin.assign_list.where(laboratory_id: laboratory.id).order(id: 'DESC')
      assign_array = []
      assigns.each do |assign|
        assign_array.push(assign.student.name)
      end
      assign_list[laboratory.name] = assign_array
    end
    return assign_list
  end

  # def student_rate_list_make
  #   students = current_admin.student
  #   student_rate_array = Array.new(students.length, ['名前'])
  #   student_rate_group = current_admin.student_rate.group(:created_at)
  #   student_rate_group.each do |student_rate_datetime|
  #     student_rate_array[0].push(student_rate_datetime.strftime("%Y/%m/%d %H:%M:%S"))
  #     current_admin.student.each_with_index do |student, row|
  #       data = student.student_rate.find_by(created_at: student_rate_datetime)
  #       # student_rate_array[row+1].push(student.name) if col == 0
  #       student_rate_array[row+1].push(data.rate)
  #     end
  #   end
  #   return student_rate_array
  # end
end
