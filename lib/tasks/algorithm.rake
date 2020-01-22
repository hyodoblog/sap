namespace :algorithm do
  desc "研究室配属アルゴリズムの実装"
  task :sap => :environment do
    User.all.each do |user|

      # SAPが稼働しているかチェック
      unless !user.config.nil? && user.config.release_flag
        next
      end

      # 日付チェック
      now_datetime = Time.zone.now
      unless user.config.start_datetime <= now_datetime && user.config.end_datetime >= now_datetime
        next
      end

      user_id = user.id

      # データの整理
      student_choice_list = student_choice_list_make(user_id)
      laboratory_choice_list = laboratory_choice_list_make(user_id)
      max_laboratory_num_list = max_laboratory_num_list_make(user_id)

      # -----------------------
      # --- アルゴリズムの実装 ---

      laboratories = Laboratory.where(user_id: user_id)
      students = Student.where(user_id: user_id)
      AssignList.where(user_id: user_id).delete_all

      # Step 1
      # 全ての学生を未配属にする
      current_assign_list = algorithm_step1(laboratories)

      # Step 2
      # 配属希望を記入した学生の配属処理
      current_assign_list = algorithm_step2(current_assign_list,
                                            student_choice_list,
                                            laboratory_choice_list,
                                            max_laboratory_num_list)

      # Step 3
      # マッチングが高い学生は配属を確定させる
      confirm_student_array = algorithm_step3(current_assign_list,
                                              student_choice_list,
                                              laboratory_choice_list,
                                              max_laboratory_num_list)

      # Step 3
      # 配属されていない学生をランダムで配属
      current_assign_list = algorithm_step4(current_assign_list,
                                            max_laboratory_num_list,
                                            students)

      # --- アルゴリズム終了 ----
      # -----------------------

      # データベースへの反映
      current_assign_list.each do |laboratory_id, student_array|
        student_array.each do |student_id|
          if confirm_student_array.include?(student_id)
            AssignList.create(user_id: user_id, laboratory_id: laboratory_id, student_id: student_id, confirm: true)
          else
            AssignList.create(user_id: user_id, laboratory_id: laboratory_id, student_id: student_id)
          end
        end
      end
    end
  end

  private

  # 学生が希望した研究室の希望リストを整理
  def student_choice_list_make(user_id)
    students = Student.where(user_id: user_id)
                   .joins(:student_choice)
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
  def laboratory_choice_list_make(user_id)
    laboratories = Laboratory.where(user_id: user_id)
                       .joins(:laboratory_choice)
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

  # 研究室配属最大人数の整理
  def max_laboratory_num_list_make(user_id)
    laboratories = Laboratory.where(user_id: user_id)
    max_laboratory_num_list = {}
    laboratories.each do |laboratory|
      max_laboratory_num_list[laboratory.id] = laboratory.max_num
    end
    return max_laboratory_num_list
  end

  def algorithm_step1(laboratories)
    return laboratories.ids.to_h do |x|
      [x, []]
    end
  end

  def algorithm_step2(current_assign_list, student_choice_list, laboratory_choice_list, max_laboratory_num_list)
    student_choice_list.each do |student_id, laboratory_choice_array|
      # 仮配属されている学生はスキップ
      if check_assign?(current_assign_list, student_id)
        next
      end

      laboratory_choice_array.each do |laboratory_id|
        # 人数制限をチェック
        # 余裕があればとりあえず配属
        max_laboratory_num = max_laboratory_num_list[laboratory_id]
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
            student_choice_list = {swap_student_id => student_choice_list[swap_student_id]}
            current_assign_list = algorithm_step2(current_assign_list, student_choice_list,
                                                  laboratory_choice_list, max_laboratory_num_list)
            break
          end
        end
      end
    end
    return current_assign_list
  end

  def algorithm_step3(current_assign_list, student_choice_list, laboratory_choice_list, max_laboratory_num_list)
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
        max_laboratory_num = max_laboratory_num_list[laboratory_id]
        if check_matching?(student_choice_array, max_laboratory_num, student_id)
          confirm_student_array.push(student_id)
        end
      end
    end
    return confirm_student_array
  end

  def algorithm_step4(current_assign_list, max_laboratory_num_list, students)
    students.each do |student|
      unless check_student_exist?(current_assign_list, student.id)
        current_assign_list.each do |laboratory_id, assign_student_array|
          if check_laboratory_limit?(current_assign_list, laboratory_id, max_laboratory_num_list[laboratory_id])
            current_assign_list[laboratory_id].push(student.id)
            break
          end
        end
      end
    end
    return current_assign_list
  end

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

  # 研究室の最大配属人数をチェック
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
    student_choice_array.each do |student_choice_id|
      if student_choice_id == student_id
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