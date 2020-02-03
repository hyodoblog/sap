class Admins::ExcelExportsController < Admins::ApplicationController
  skip_before_action :release_true_check!
  skip_before_action :end_check!

  def all

  end
  
  def assign
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

    respond_to do |format|
      format.html
      format.xlsx do
        generate_assign_lists_xlsx(assign_list)
      end
    end
  end

  def choice
  end

  def rate
    
  end

  def info

  end

  private

  def generate_assign_lists_xlsx(assign_list)
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(name: '配属結果') do |sheet|
        sheet.add_row ['研究室', '学生']
        assign_list.each do |laboratory_name, assign_student_array|
          sheet.add_row do |row|
            row.add_cell(laboratory_name)
            assign_student_array.each do |student_name|
              row.add_cell(student_name)
            end
          end
        end
      end
      send_data(p.to_stream.read,
                type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                filename: "assign_list.xlsx")
    end
  end
end
