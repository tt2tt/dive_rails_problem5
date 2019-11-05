require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    current_user = User.create(name: 'exam', email: "exam@example.com", password: "examexam")
  end

  it 'nameが空ならバリテーションが通らない' do
    user = User.create(name: '', email: 'exam@exam.com', password: 'a' * 6, password_confirmation: 'a' * 6)
    expect(user).not_to be_valid
  end

  it 'emailが空ならバリテーションが通らない' do
      user = User.new(name: '仮名前', email: '', password: 'a' * 6, password_confirmation: 'a' * 6)
      expect(user).not_to be_valid
  end

  it 'passwordが空ならバリテーションが通らない' do
    user = User.new(name: '仮名前', email: 'exam@exam.com', password: '', password_confirmation: '' )
    expect(user).not_to be_valid
  end

  it 'emailが重複していればバリテーションを通らない' do
    User.create(name: '仮名前', email: 'exam@exam.com', password: 'a' * 6, password_confirmation: 'a' * 6)
    user = User.new(name: '仮名前1', email: 'exam@exam.com', password: 'b' * 6, password_confirmation: 'b' * 6)
    expect(user).not_to be_valid
  end

  it 'emailがフォーマットから外れていればバリテーションが通らない' do
    user = User.new(name: '仮名前', email: 'a' * 10, password: 'a' * 6, password_confirmation: 'a' * 6)
    expect(user).not_to be_valid
  end

  it 'パスワードが5文字以下ならバリテーションが通らない' do
    user = User.new(name: '仮名前', email: 'exam@exam.com', password: 'a' * 5, password_confirmation: 'a' * 5)
    expect(user).not_to be_valid
  end

  it '全ての制限を満たしていればバリテーションが通る' do
    user = User.new(name: '仮名前', email: 'exam@exam.com', password: 'a' * 6, password_confirmation: 'a' * 6)
    expect(user).to be_valid
  end
  
end
