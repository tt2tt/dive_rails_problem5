require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    FactoryBot.create(:forth_task)
  end
  scenario 'タスク一覧のテスト' do
    visit tasks_path

    expect(page).to have_content 'test1'
    expect(page).to have_content 'sample2'
    expect(page).to have_content 'mof3'
  end

  scenario 'タスク作成のテスト' do
    visit new_task_path

    fill_in 'タスク名', with: '買い物に行く'
    fill_in 'タスク詳細', with: '午後7時にスーパーでカレーの材料を買う'

    click_button 'task_save'

    visit tasks_path

    expect(page).to have_content '買い物に行く'
    expect(page).to have_content '午後7時にスーパーでカレーの材料を買う'
  end

  scenario 'タスク詳細のテスト' do
    visit tasks_path(id: 1)

    expect(page).to have_content 'test1'
  end

  scenario 'タスクが作成日時の降順に並んでいるかのテスト' do
    visit tasks_path

    first_task = all('.tasks .task')[0]
    forth_task = all('.tasks .task')[3]

    expect(first_task).to have_content 'manyou4'
    expect(forth_task).to have_content 'test1'
  end

  scenario 'タスクが終了期限によって昇順に並び変えられるかのテスト' do
    visit tasks_path(sort_expired: "true")

    first_task = all('.tasks .task')[0]
    forth_task = all('.tasks .task')[3]

    expect(first_task).to have_content 'manyou4'
    expect(forth_task).to have_content 'mof3'
  end

  scenario 'タスクが優先度によって降順に並び変えられるかのテスト' do
      visit tasks_path(sort_priority: "true")
      
      first_task = all('.tasks .task')[0]
      forth_task = all('.tasks .task')[3]

      expect(first_task).to have_content 'manyou4'
      expect(forth_task).to have_content 'test1'
  end

  scenario 'タスクを検索できるかのテスト' do
    visit tasks_path

    fill_in 'タスク名', with: 'test_task_01'
    select "完了", from: "task[status]"

    click_on "検索"

    expect(page).to have_content 'manyou4'
  end
end
