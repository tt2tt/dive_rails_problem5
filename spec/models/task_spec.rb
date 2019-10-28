require 'rails_helper'

RSpec.describe Task, type: :model do

  it 'nameが空ならバリテーションが通らない' do
    task =  Task.new(name: '', detail: '仮タスク詳細')
    expect(task).not_to be_valid
  end

  it 'detailがからならバリテーションが通らない' do
    task =  Task.new(name: '仮タスク名', detail: '')
    expect(task).not_to be_valid
  end

  it 'nameが51文字以上ならバリテーションが通らない' do
    task =  Task.new(name: 'a' * 51, detail: '仮タスク詳細')
    expect(task).not_to be_valid
  end

  it 'detailが201文字以上ならバリテーションが通らない' do
    task = Task.new(name: '仮タスク名' , detail: 'a' * 201)
    expect(task).not_to be_valid
  end

  it 'nameとdetailに内容があり文字数制限を守っていればバリテーションが通る' do
    task = Task.new(name: '仮タスク名', detail: '仮タスク詳細')
    expect(task).to be_valid
  end
end
