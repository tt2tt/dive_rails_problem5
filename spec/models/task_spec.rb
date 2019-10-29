require 'rails_helper'
require 'date'

background do
  FactoryBot.create(:task)
  FactoryBot.create(:second_task)
  FactoryBot.create(:third_task)
  FactoryBot.create(:forth_task)
  time = Time.now
end

RSpec.describe Task, type: :model do

  it 'nameが空ならバリテーションが通らない' do
    task =  Task.new(name: '', detail: '仮タスク詳細', deadline: time)
    expect(task).not_to be_valid
  end

  it 'detailがからならバリテーションが通らない' do
    task =  Task.new(name: '仮タスク名', detail: '', deadline: time)
    expect(task).not_to be_valid
  end

  it 'nameが51文字以上ならバリテーションが通らない' do
    task =  Task.new(name: 'a' * 51, detail: '仮タスク詳細', deadline: time)
    expect(task).not_to be_valid
  end

  it 'detailが201文字以上ならバリテーションが通らない' do
    task = Task.new(name: '仮タスク名' , detail: 'a' * 201, deadline: time)
    expect(task).not_to be_valid
  end

  it 'nameとdetailに内容があり文字数制限を守っていればバリテーションが通る' do
    task = Task.new(name: '仮タスク名', detail: '仮タスク詳細', deadline: time)
    expect(task).to be_valid
  end
end
