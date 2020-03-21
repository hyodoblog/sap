module Algorithm
  def algo_update(admin)
    # 変数の初期化
    student_choice_list = student_choice_list_make(admin)
    laboratory_choice_list = laboratory_choice_list_make(admin)
    students = admin.student.order(id: 'DESC')
    laboratories = admin.laboratory
    num_students = students.length
    num_laboratories = laboratories.length
    max_student_rate = admin.max_choice_student
    max_laboratory_rate = admin.max_choice_laboratory

    # -----------------------
    # --- アルゴリズムの実装 ---

    # Step 0
    # レートの更新
    students_rate_update(laboratory_choice_list,
                         students,
                         max_student_rate,
                         admin.id)
    laboratories_rate_update(student_choice_list,
                             laboratories,
                             max_laboratory_rate,
                             admin.id)

    # 研究室をレート順にソート
    laboratories = admin.laboratory.order(latest_rate: 'DESC')

    # Step 1
    # 研究室配属人数を整理
    assign_laboratory_num_list = algorithm_step1(laboratories,
                                              num_students,
                                              num_laboratories)

    # Step 2
    # 全ての学生を未配属にする
    current_assign_list = algorithm_step2(laboratories)

    # Step 3
    # 配属希望を記入した学生の配属処理
    current_assign_list = algorithm_step3(current_assign_list,
                                          student_choice_list,
                                          laboratory_choice_list,
                                          assign_laboratory_num_list)
    student_choice_list = student_choice_list_make(admin) # 参照渡しになり値が変更されるため初期化

    # Step 4
    # マッチングが高い学生は配属を確定させる
    confirm_student_array = algorithm_step4(student_choice_list,
                                            laboratory_choice_list,
                                            assign_laboratory_num_list)

    # Step 5
    # 配属されていない学生をランダムで配属
    current_assign_list = algorithm_step5(current_assign_list,
                                          assign_laboratory_num_list,
                                          students)

    # --- アルゴリズム終了 ----
    # -----------------------

    # 過去の配属データをリセット
    admin.assign_list.delete_all

    # データベースへの反映
    current_assign_list.each do |laboratory_id, student_array|
      student_array.each do |student_id|
        if confirm_student_array.include?(student_id)
          admin.assign_list.create(laboratory_id: laboratory_id, student_id: student_id, confirm: true)
        else
          admin.assign_list.create(laboratory_id: laboratory_id, student_id: student_id)
        end
      end
    end
  end

  private

  # ---- レートの更新 ----
  # 学生
  def students_rate_update(laboratory_choice_list, students, max_student_rate, admin_id)
    student_rate_list = {}
    laboratory_choice_list.each do |laboratory_id, student_choice_array|
      minus_point = 0
      student_choice_array.each do |student_id|
        if student_rate_list[student_id].nil?
          if minus_point == 0
            point = max_student_rate * 10
          else
            point = (max_student_rate - minus_point)
          end
          student_rate_list[student_id] = point
        else
          if minus_point == 0
            point = max_student_rate * 10
          else
            point = (max_student_rate - minus_point)
          end
          student_rate_list[student_id] += point
        end
        minus_point += 1
      end
    end
    # データベースに反映
    students.each do |student|
      student_rate_exit = false
      student_rate_list.each do |student_id, rate|
        if student.id == student_id
          student_rate_exit = true
          student.update_attributes(latest_rate: rate)
          student_rate_list.delete(student_id)
          break
        end
      end
      # 希望されていない場合 0
      unless student_rate_exit
        rate = 0
        student.update_attributes(latest_rate: rate)
      end
    end
  end
  # 研究室
  def laboratories_rate_update(student_choice_list, laboratories, max_laboratory_rate, admin_id)
    laboratory_rate_list = {}
    student_choice_list.each do |student_id, laboratory_choice_array|
      minus_point = 0
      laboratory_choice_array.each do |laboratory_id|
        if laboratory_rate_list[laboratory_id].nil?
          if minus_point == 0
            point = max_laboratory_rate * 10
          else
            point = (max_laboratory_rate - minus_point)
          end
          laboratory_rate_list[laboratory_id] = point
        else
          if minus_point == 0
            point = max_laboratory_rate * 10
          else
            point = (max_laboratory_rate - minus_point)
          end
          laboratory_rate_list[laboratory_id] += point
        end
        minus_point += 1
      end
    end
    # データベースに反映
    laboratories.each do |laboratory|
      laboratory_rate_exit = false
      laboratory_rate_list.each do |laboratory_id, rate|
        if laboratory.id == laboratory_id
          laboratory_rate_exit = true
          laboratory.update_attributes(latest_rate: rate)
          laboratory_rate_list.delete(laboratory_id)
          break
        end
      end
      # 希望されていない場合 0
      unless laboratory_rate_exit
        rate = 0
        laboratory.update_attributes(latest_rate: rate)
      end
    end
  end

  # ---- 希望リストの整理 ----
  # 学生が希望した研究室の希望リストを整理
  def student_choice_list_make(admin)
    students = admin.student.joins(:student_choice)
                                   .includes(:student_choice)
                                   .order('student_choices.student_id')
                                   .order('student_choices.rank')
    student_choice_list = {}
    students.each do |student|
      laboratory_array = []
      student.student_choice.each do |choice|
        laboratory_array.push(choice.laboratory_id)
      end
      student_choice_list[student.id] = laboratory_array
    end
    return student_choice_list
  end
  # 研究室が希望した学生の希望リストを整理
  def laboratory_choice_list_make(admin)
    laboratories = admin.laboratory.joins(:laboratory_choice)
                                   .includes(:laboratory_choice)
                                   .order('laboratory_choices.laboratory_id')
                                   .order('laboratory_choices.rank')
    laboratory_choice_list = {}
    laboratories.each do |laboratory|
      student_array = []
      laboratory.laboratory_choice.each do |choice|
        student_array.push(choice.student_id)
      end

      laboratory_choice_list[laboratory.id] = student_array
    end
    return laboratory_choice_list
  end

  # ---- アルゴリズム ----
  # Step 1
  def algorithm_step1(laboratories, num_students, num_laboratories)
    # Step 1
    avarage = num_students.to_i / num_laboratories.to_i
    # Step 2, 3, 4
    assign_laboratory_num_list = {}
    num_tmp_assignment = 0
    remain_laboratory_array = []
    laboratories.each do |laboratory|
      if !laboratory.max_num.nil?
        assign_laboratory_num_list[laboratory.id] = laboratory.max_num
        num_tmp_assignment += laboratory.max_num
      else
        assign_laboratory_num_list[laboratory.id] = 0
        remain_laboratory_array.push(laboratory.id)
      end
    end
    num_remain_students = num_students - num_tmp_assignment
    # Step 5
    index = 1
    while (num_remain_students > 0)
      remain_laboratory_array.each do |laboratory_id|
        assign_laboratory_num_list[laboratory_id] += 1
        num_remain_students -= 1
      end
      # laboratories.each do |laboratory|
      #   if !assign_laboratory_num_list[laboratory.id]
      #     assign_laboratory_num_list[laboratory.id] += 1
      #     num_remain_students -= 1
      #   end
      #   if laboratory.max_num.nil? || laboratory.max_num >= (avarage + index)
      #     assign_laboratory_num_list[laboratory.id] += 1
      #     num_remain_students -= 1
      #     if (num_remain_students == 0)
      #       break
      #     end
      #   end
      # end
      index += 1
    end
    return assign_laboratory_num_list
  end
  # Step 2
  def algorithm_step2(laboratories)
    return laboratories.ids.to_h do |x|
      [x, []]
    end
  end
  # Step 3
  def algorithm_step3(current_assign_list, student_choice_list, laboratory_choice_list, assign_laboratory_num_list)
    student_choice_list.each do |student_id, laboratory_choice_array|
      # 仮配属されている学生はスキップ
      if check_assign?(current_assign_list, student_id)
        next
      end

      laboratory_choice_array.each do |laboratory_id|
        # 人数制限をチェック
        # 余裕があればとりあえず配属
        max_laboratory_num = assign_laboratory_num_list[laboratory_id]
        if check_laboratory_limit?(current_assign_list, laboratory_id, max_laboratory_num)
          current_assign_list[laboratory_id].push(student_id)
          break
          # 研究室が希望する学生の優先順位をチェック
        else
          student_choice_array = laboratory_choice_list[laboratory_id]
          current_assign_student_array = current_assign_list[laboratory_id]
          check_flag, swap_student_id = check_student_priority(current_assign_student_array,
                                                               student_choice_array, student_id)
          if check_flag # 優先順位が高い学生と一番低い学生を入れ替え、配属を取り消された学生はもう一度アルゴリズムstep２を実施
            current_assign_list[laboratory_id].delete(swap_student_id)
            current_assign_list[laboratory_id].push(student_id)
            student_choice_list[swap_student_id].delete(laboratory_id)
            current_assign_list = algorithm_step3(current_assign_list, student_choice_list,
                                                  laboratory_choice_list, assign_laboratory_num_list)
            break
          end
        end
      end
    end
    return current_assign_list
  end
  # Step 4
  def algorithm_step4(student_choice_list, laboratory_choice_list, assign_laboratory_num_list)
    confirm_student_array = []
    student_choice_list.each do |student_id, laboratory_choice_array|
      laboratory_choice_array.each_with_index do |laboratory_id, index|
        if index != 0 # 第１希望以外はスキップ
          break
        end
        student_choice_array = laboratory_choice_list[laboratory_id]
        if student_choice_array.nil? # 研究室が希望リストを提出していない場合スキップ
          next
        end
        max_laboratory_num = assign_laboratory_num_list[laboratory_id]
        if check_matching?(student_choice_array, max_laboratory_num, student_id)
          confirm_student_array.push(student_id)
        end
      end
    end
    return confirm_student_array
  end
  # Step 5
  def algorithm_step5(current_assign_list, assign_laboratory_num_list, students)
    students.each do |student|
      unless check_student_exist?(current_assign_list, student.id)
        current_assign_list.each do |laboratory_id, assign_student_array|
          if check_laboratory_limit?(current_assign_list, laboratory_id, assign_laboratory_num_list[laboratory_id])
            current_assign_list[laboratory_id].push(student.id)
            break
          end
        end
      end
    end
    return current_assign_list
  end

  # ---- 関数群 ----
  # 仮配属チェック
  # current_assign_listにstudent_idが含まれているかチェック
  # 含まれていれば    true
  # 含まれていなければ false
  def check_assign?(current_assign_list, student_id)
    current_assign_list.each do |laboratory_id, student_array|
      if student_array.include?(student_id)
        return true
      end
    end
    return false
  end
  # マッチング度合いをチェック
  # 高ければ true
  # 低ければ false
  def check_matching?(student_choice_array, max_laboratory_num, student_id)
    rank = 1
    student_choice_array.each do |student_choice_id|
      if max_laboratory_num < rank
        return false
      elsif student_choice_id === student_id
        return true
      end
      rank += 1
    end
    return false
  end
  # 研究室の配属確定人数をチェック
  # 超えていなければ true
  # 超えていれば    false
  def check_laboratory_limit?(current_assign_list, laboratory_id, max_laboratory_num)
    if max_laboratory_num.nil? || current_assign_list[laboratory_id].length < max_laboratory_num
      return true
    else
      return false
    end
  end
  # 研究室が希望している学生の優先度をチェック
  # 優先順位が高く入れ替える場合 true
  # 入れ替えない場合           false
  def check_student_priority(current_assign_student_array, student_choice_array, student_id)
    flag = false
    if student_choice_array.nil?
      return false, nil
    end
    student_choice_array.each do |student_choice_id|
      if student_choice_id == student_id
        current_assign_student_array.each do |current_assign_student_id|
          unless student_choice_array.include?(current_assign_student_id)
            return true, current_assign_student_id
          end
        end
        flag = true
        next
      end
      # 学生が研究室の希望リストに存在したとき
      # 優先順位の低い学生を探す
      while flag
        student_choice_array.reverse_each do |student_choice_id|
          if student_choice_id == student_id
            return false, nil
          else
            current_assign_student_array.each do |assign_student_id|
              if assign_student_id == student_choice_id
                return true, assign_student_id
              end
            end
          end
        end
        # 研究室が希望した学生リストにstudent_idが存在しない場合
        return false, nil
      end
    end
    return false, nil
  end
  # リストの中に学生が存在するかどうかチェック
  # 存在すれば    true
  # 存在しなければ false
  def check_student_exist?(current_assign_list, student_id)
    current_assign_list.each do |laboratory_id, assign_student_array|
      assign_student_array.each do |assign_student_id|
        if assign_student_id == student_id
          return true
        end
      end
    end
    return false
  end
end