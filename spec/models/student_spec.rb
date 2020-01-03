require 'rails_helper'

RSpec.describe Student, type: :model do
  describe '#name' do
    it '空文字は無効' do
      student = Student.new()
      student.valid?
      expect(student.errors.messages[:name]).to include('入力されていません')
    end

    it '30文字以上は無効' do
      student = Student.new(name: '1234567890123456789012345678900')
      student.valid?
      expect(student.errors.messages[:name]).to include('入力されていません')
    end
  end
end
