require 'rails_helper'
require 'date'

RSpec.describe Task, type: :model do

  time = Time.now

  it 'nameが空ならバリテーションが通らない' do
    task =  Task.new(name: '', detail: '仮タスク詳細', deadline: time, status: '未着手', priority: '高')
    expect(task).not_to be_valid
  end

  it 'detailがからならバリテーションが通らない' do
    task =  Task.new(name: '仮タスク名', detail: '', deadline: time, status: '着手中', priority: '高')
    expect(task).not_to be_valid
  end

  it 'nameが51文字以上ならバリテーションが通らない' do
    task =  Task.new(name: 'a' * 51, detail: '仮タスク詳細', deadline: time, status: '完了', priority: '高')
    expect(task).not_to be_valid
  end

  it 'detailが201文字以上ならバリテーションが通らない' do
    task = Task.new(name: '仮タスク名' , detail: 'a' * 201, deadline: time, status: '完了', priority: '高')
    expect(task).not_to be_valid
  end

  it 'nameとdetailに内容があり文字数制限を守っていればバリテーションが通る' do
    task = Task.new(name: '仮タスク名', detail: '仮タスク詳細', deadline: time, status: '完了', priority: '高')
    expect(task).to be_valid
  end

  it 'タスク名のみで絞り込みができる' do
    FactoryBot.create(:task)
    result1 = FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    FactoryBot.create(:forth_task)

    result = Task.search(task = {name: 'test_task_02', status: ''})[0]

    expect(result).to eq result1
  end

  it 'ステータスのみで絞り込みができる' do
    result1 = FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    FactoryBot.create(:forth_task)

    result = Task.search(task = {name: '', status: '未着手'})[0]

    expect(result).to eq result1
  end

  it 'タスク名とステータスで絞り込みできる' do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    result1 = FactoryBot.create(:forth_task)

    result = Task.search(task = {name: 'test_task_01', status: '完了'})[0]

    expect(result).to eq result1
  end

end
