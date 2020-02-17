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
        sheet.add_row %w(Eメール 大学名 学部 学科 連絡先メール 最大学生希望人数 最大研究室希望数 最大配属確定学生数 希望提出開始日 希望提出終了日 閲覧終了日)
        sheet.add_row do |row|
          row.add_cell(current_admin.email)
          row.add_cell(current_admin.university_name)
          row.add_cell(current_admin.faculty_name)
          row.add_cell(current_admin.department_name)
          row.add_cell(current_admin.contact_email)
          row.add_cell(current_admin.max_choice_student)
          row.add_cell(current_admin.max_choice_laboratory)
          row.add_cell(current_admin.max_confirmed_student)
          row.add_cell(current_admin.start_datetime.to_s(:datetime_jp))
          row.add_cell(current_admin.end_datetime.to_s(:datetime_jp))
          row.add_cell(current_admin.view_end_datetime.to_s(:datetime_jp))
        end
      end
      p.workbook.add_worksheet(name: '学生情報') do |sheet|
        sheet.add_row %w(学籍番号 名前 Eメール トータルレート 希望研究室リスト)
        current_admin.student.each do |student|
          sheet.add_row do |row|
            row.add_cell(student.student_num)
            row.add_cell(student.name)
            row.add_cell(student.email)
            row.add_cell(student.total_rate)
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
        sheet.add_row %w(研究室名 名前 最大配属人数 Eメール トータルレート 希望学生リスト)
        current_admin.laboratory.each do |laboratory|
          sheet.add_row do |row|
            row.add_cell(laboratory.name)
            row.add_cell(laboratory.professor_name)
            row.add_cell(laboratory.max_num)
            row.add_cell(laboratory.email)
            row.add_cell(laboratory.total_rate)
            laboratory_choice_student_cell = ''
            laboratory.laboratory_choice.each do |choice_student|
              laboratory_choice_student_cell += ', ' unless !laboratory_choice_student_cell.empty?
              laboratory_choice_student_cell += choice_student.student.name
            end
            row.add_cell(laboratory_choice_student_cell)
          end
        end
      end
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
end
