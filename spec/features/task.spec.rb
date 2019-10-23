require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  scenario 'タスク一覧のテスト' do
    Task.create!(name: 'test_task_01', detail: 'test1')
    Task.create!(name: 'test_task_02', detail: 'sample2')

    visit tasks_path

    expect(page).to have_content 'test1'
    expect(page).to have_content 'sample2'
  end

  scenario 'タスク作成のテスト' do
    visit new_task_path

    fill_in 'Name', with: '買い物に行く'
    fill_in 'Detail', with: '午後7時にスーパーでカレーの材料を買う'

    click_button 'task_save'

    visit tasks_path

    expect(page).to have_content '買い物に行く'
    expect(page).to have_content '午後7時にスーパーでカレーの材料を買う'
  end

  scenario 'タスク詳細のテスト' do
    Task.create!(name: 'test_task_03', detail: 'test3')

    visit tasks_path
    click_link 'Show'

    expect(page).to have_content 'test3'
  end
end
